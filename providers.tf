terraform {
  required_version = ">= 1.9"
  backend "s3" {
    bucket = "nadav-project"
    key    = "main/terraform.tfstate"
    region = "us-east-2"
    # dynamodb_table = "terraform-lock-table" # Uncomment this line if you want to use DynamoDB for locking - make sure you create the table first
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.15.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  kubeconfig_exists = fileexists(var.kubeconfig_path)
}

provider "kubernetes" {
  config_path = local.kubeconfig_exists ? var.kubeconfig_path : null
}

provider "helm" {
  kubernetes {
    config_path = local.kubeconfig_exists ? var.kubeconfig_path : null
  }
}