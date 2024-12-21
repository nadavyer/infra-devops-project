variable "vpc_id" {
  description = "ID of the VPC"

}

variable "cluster_name" {
  description = "Name of the EKS cluster"

}

variable "nginx_ingress_controller_namespace" {
  description = "The namespace to deploy the AWS Load Balancer Controller"
  type        = string
  default     = "nginx"
}

variable "asg_name" {
  description = "The name of the Auto Scaling Group created for the EKS node group"
  type        = string

}

variable "nodegroup_sg_id" {
  description = "The ID of the security group associated with the EKS node group"
  type        = string
}