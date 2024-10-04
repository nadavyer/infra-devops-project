# Replace these data sources with your specific values
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    "kubernetes.io/role/elb" = "1"
  }
}

resource "kubernetes_namespace" "nginx" {
  metadata {
    name = var.nginx_ingress_controller_namespace
  }
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ALB for the EKS Cluster
resource "aws_lb" "main" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.public.ids
}

resource "aws_lb_target_group" "http" {
  name        = "eks-http"
  target_type = "instance"
  port        = "30080"
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.main.id

  health_check {
    path     = "/"
    port     = "30080"
    protocol = "HTTP"
    matcher  = "200,404"
  }

  tags = {
    Terraform = "true"
  }
}

# resource "aws_lb_target_group" "https" {
#   name        = "eks-dev-https"
#   target_type = "instance"
#   port        = "30443"
#   protocol    = "HTTPS"
#   vpc_id      = data.aws_vpc.main.id

#   health_check {
#     path     = "/"
#     port     = "30443"
#     protocol = "HTTPS"
#     matcher  = "200,404"
#   }

#   tags = {
#     Terraform = "true"
#   }
# }

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.main.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   # certificate_arn   = "arn:aws:acm:us-east-4:4206969777:certificate/whoa-some-id-was-here"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.https.arn
#   }
# }

resource "aws_autoscaling_attachment" "asg_alb_attachment_http" {
  autoscaling_group_name = var.asg_name
  lb_target_group_arn    = aws_lb_target_group.http.arn
}

# resource "aws_autoscaling_attachment" "asg_alb_attachment_https" {
#   autoscaling_group_name = "some-asg-name-123"
#   lb_target_group_arn    = aws_lb_target_group.https.arn
# }

# Helm Release for NGINX Ingress Controller
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.11.2"

  # Set the service type to NodePort
  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = "30080"
  }

  # Disable the publishService feature
  set {
    name  = "controller.publishService.enabled"
    value = "false"
  }

  # Ingress class configuration
  set {
    name  = "controller.ingressClassResource.name"
    value = "nginx"
  }

  set {
    name  = "controller.ingressClassResource.controllerValue"
    value = "k8s.io/ingress-nginx"
  }

  # Configure service account
  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = "nginx-ingress-serviceaccount"
  }
}