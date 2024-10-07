module "lb_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name                              = "nadav_proj_eks_lb"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = "arn:aws:iam::445521015129:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/43DBE0633266621756634A68BD542D76"
      namespace_service_accounts = ["${var.aws_lb_controller_namespace}:${var.aws_lb_controller_service_account_name}"]
    }
  }
}

resource "kubernetes_service_account" "service-account" {
  metadata {
    name      = var.aws_lb_controller_service_account_name
    namespace = var.aws_lb_controller_namespace
    labels = {
      "app.kubernetes.io/name"      = var.aws_lb_controller_service_account_name
      "app.kubernetes.io/component" = "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = module.lb_role.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}

# data "aws_iam_policy_document" "alb_ingress_policy" {
#   statement {
#     actions = [
#       "iam:CreateServiceLinkedRole",
#       "ec2:DescribeAccountAttributes",
#       "ec2:DescribeAddresses",
#       "ec2:DescribeInternetGateways",
#       "ec2:DescribeVpcs",
#       "ec2:DescribeSubnets",
#       "ec2:DescribeSecurityGroups",
#       "ec2:DescribeInstances",
#       "ec2:DescribeNetworkInterfaces",
#       "ec2:DescribeTags",
#       "ec2:ModifySecurityGroup",
#       "elasticloadbalancing:DescribeLoadBalancers",
#       "elasticloadbalancing:DescribeLoadBalancerAttributes",
#       "elasticloadbalancing:DescribeListeners",
#       "elasticloadbalancing:DescribeListenerCertificates",
#       "elasticloadbalancing:DescribeSSLPolicies",
#       "elasticloadbalancing:DescribeRules",
#       "elasticloadbalancing:DescribeTargetGroups",
#       "elasticloadbalancing:DescribeTargetGroupAttributes",
#       "elasticloadbalancing:DescribeTargetHealth",
#       "elasticloadbalancing:DescribeTags"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_policy" "alb_ingress_policy" {
#   name        = "alb-ingress-policy"
#   description = "Policy for AWS Load Balancer Controller"
#   policy      = data.aws_iam_policy_document.alb_ingress_policy.json
# }

# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     principals {
#       type        = "Federated"
#       identifiers = ["arn:aws:iam::${var.aws_account_id}:oidc-provider/oidc.eks.${var.aws_region}.amazonaws.com/id/${var.cluster_oidc_id}"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${var.cluster_oidc_id}:sub"
#       values   = ["system:serviceaccount:${var.namespace}:${var.aws_lb_controller_service_account_name}"]
#     }
#   }
# }

# resource "aws_iam_role" "alb_ingress_role" {
#   name               = "alb-ingress-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
# }

# resource "aws_iam_role_policy_attachment" "alb_ingress_attach" {
#   role       = aws_iam_role.alb_ingress_role.name
#   policy_arn = aws_iam_policy.alb_ingress_policy.arn
# }

# resource "kubernetes_service_account" "aws_load_balancer_controller" {
#   metadata {
#     name      = var.aws_lb_controller_service_account_name
#     namespace = var.namespace
#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.alb_ingress_role.arn
#     }
#   }

#   automount_service_account_token = true
# }

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = var.aws_lb_controller_namespace

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "replicaCount"
    value = "1"
  }

  set_sensitive {
    name  = "serviceAccount.create"
    value = "false"
  }

  set_sensitive {
    name  = "serviceAccount.name"
    value = var.aws_lb_controller_service_account_name
  }

  # set_sensitive {
  #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/audience"
  #   value = var.cluster_ca_thumbprint
  # }

  # set_sensitive {
  #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  #   value = aws_iam_role.alb_ingress_role.arn
  # }

  # depends_on = [
  #   aws_iam_role_policy_attachment.alb_ingress_attach,
  # ]
}