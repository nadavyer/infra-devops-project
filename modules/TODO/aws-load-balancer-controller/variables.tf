variable "aws_account_id" {
  description = "AWS Account ID"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "aws_region" {
  description = "AWS region to deploy to"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "cluster_ca_thumbprint" {
  description = "The certificate authority thumbprint of the EKS cluster"
  type        = string
}

variable "cluster_oidc_url" {
  description = "The OIDC issuer URL of the EKS cluster"
  type        = string
}

variable "aws_lb_controller_namespace" {
  description = "The namespace to deploy the AWS Load Balancer Controller"
  type        = string
  default     = "kube-system"
}

variable "aws_lb_controller_service_account_name" {
  description = "The name of the service account"
  type        = string
  default     = "aws-load-balancer-controller-v2"
}

variable "cluster_oidc_id" {
  description = "The OIDC issuer ID of the EKS cluster"
  type        = string
}