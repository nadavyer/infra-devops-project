terraform {
  required_version = ">= 1.9"
  backend "s3" {
    bucket = "nadav-project"
    key    = "main/terraform.tfstate"
    region = "us-east-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6"
    }
  }
}

provider "aws" {
  region = var.region
}
