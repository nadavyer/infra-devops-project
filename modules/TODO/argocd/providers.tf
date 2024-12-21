terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.15.0"
    }

    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 5.60.0"
    # }
  }

  required_version = ">= 0.14"
}

provider "kubernetes" {
  config_path = local.kubeconfig
}

provider "helm" {
  kubernetes {
    config_path = local.kubeconfig
  }
}

locals {
  kubeconfig = "/Users/nadav.yerushalmi/CTX//ops-ni-us-east-1-v1.26.4.k8s.local.config" //ops
  # kubeconfig = "/Users/nadav.yerushalmi/CTX//playground-ni-us-east-2-v1-27-3-eks.config"
}