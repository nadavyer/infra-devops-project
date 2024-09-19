variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "cluster_name" {
  description = "The name of the project"
  type        = string

}

variable "eks_version" {
  description = "The desired Kubernetes version for the EKS cluster"
  type        = string
}