variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "aws_lb_conotroller_namespace" {
  description = "The namespace to deploy the AWS Load Balancer Controller"
  type        = string
  default     = "kube-system"
}

variable "cluster_name" {
  description = "The name of the project"
  type        = string

}

variable "eks_version" {
  description = "The desired Kubernetes version for the EKS cluster"
  type        = string
}

variable "kubeconfig_path" {
  description = "The path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "aws_lb_controller_service_account_name" {
  description = "The name of the service account"
  type        = string
  default     = "aws-load-balancer-controller-v4"
}

variable "nginx_ingress_controller_namespace" {
  description = "The namespace to deploy the Nginx Ingress Controller"
  type        = string
  default     = "nginx"
}