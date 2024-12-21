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
  source             = "./modules/eks/cluster"
  cluster_name       = var.cluster_name
  eks_version        = var.eks_version
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids


  depends_on = [module.vpc]
}

module "eks_nodegroup" {
  source                   = "./modules/eks/nodegroup"
  cluster_name             = var.cluster_name
  node_group_instance_type = var.node_group_instance_type
  node_group_desired_size  = var.node_group_desired_size
  node_group_min_size      = var.node_group_min_size
  node_group_max_size      = var.node_group_max_size
  node_group_disk_size     = var.node_group_disk_size

  depends_on = [module.eks]
}

module "nginx-ingress-controller" {
  source                             = "./modules/nginx-ingress-controller"
  vpc_id                             = module.vpc.vpc_id
  cluster_name                       = var.cluster_name
  nginx_ingress_controller_namespace = var.nginx_ingress_controller_namespace
  asg_name                           = module.eks_nodegroup.nodegroup_name
  nodegroup_sg_id                    = module.eks.cluster_sg_id

  depends_on = [module.eks_nodegroup]
}

module "kube-state-metrics" {
  source    = "./modules/kube-state-metrics"
  namespace = var.kube_state_metrics_namespace

  depends_on = [module.eks_nodegroup]
}

module "k8s-dashboard" {
  source                  = "./modules/k8s-dashboard"
  ingress_host            = module.nginx-ingress-controller.alb_dns_name
  k8s_dashboard_namespace = var.k8s_dashboard_namespace

  depends_on = [module.eks_nodegroup]
}