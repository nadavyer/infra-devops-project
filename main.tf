locals {
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  region       = var.region
  # vpc_cidr = var.vpc_cidr
  # public_subnet_cidr = var.public_subnet_cidr
  # private_subnet_cidr = var.private_subnet_cidr
  # availability_zones = var.availability_zones
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  eks_version        = var.eks_version
  public_subnet_ids  = local.public_subnet_ids
  private_subnet_ids = local.private_subnet_ids
}

# module "aws-load-balancer-controller" {
#   source                                 = "./modules/aws-load-balancer-controller"
#   cluster_name                           = var.cluster_name
#   vpc_id                                 = module.vpc.vpc_id
#   aws_region                             = var.region
#   cluster_ca_thumbprint                  = module.eks.cluster_ca_thumbprint
#   cluster_oidc_url                       = module.eks.cluster_oidc_url
#   aws_lb_controller_namespace            = var.aws_lb_conotroller_namespace
#   aws_lb_controller_service_account_name = var.aws_lb_controller_service_account_name
#   cluster_oidc_id                        = "43DBE0633266621756634A68BD542D76"
#   aws_account_id                         = module.eks.account_id
# }

module "nginx-ingress-controller" {
  source = "./modules/nginx-ingress-controller"
  vpc_id = module.vpc.vpc_id
  cluster_name = var.cluster_name
  nginx_ingress_controller_namespace = var.nginx_ingress_controller_namespace
  asg_name = module.eks.asg_name
}