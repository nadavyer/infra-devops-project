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