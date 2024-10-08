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

variable "node_group_instance_type" {
  description = "The instance type for the worker nodes"
  type        = string
  default     = "t3.medium"
  
}

variable "node_group_disk_size" {
  description = "The disk size for the worker nodes"
  type        = number
  default     = 20
  
}

variable "node_group_desired_size" {
  description = "The desired number of worker nodes"
  type        = number
  default     = 1
  
}

variable "node_group_max_size" {
  description = "The maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "node_group_min_size" {
  description = "The minimum number of worker nodes"
  type        = number
  default     = 1
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

variable "kube_state_metrics_namespace" {
  description = "The namespace to deploy kube-state-metrics"
  type        = string
  default     = "kube-system"
}

variable "k8s_dashboard_namespace" {
  description = "The namespace to install the Kubernetes Dashboard into"
  type        = string
  default     = "kube-system"
}