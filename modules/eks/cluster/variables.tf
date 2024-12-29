variable "cluster_name" {
  description = "The name of the project"
  type        = string
  default     = "nadav-project"
}

variable "eks_version" {
  description = "The desired Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["audit", "api", "authenticator", "controllerManager", "scheduler"]
}

variable "authentication_mode" {
  description = "The authentication mode for the cluster. Valid values are `CONFIG_MAP`, `API` or `API_AND_CONFIG_MAP`"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
  default     = ["subnet-05528d6fe1dbb40cd", "subnet-00ee6a2ef24ed89d7", "subnet-0c28beef4f48b0f56"]
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
  default     = ["subnet-0b3b3b3b3b3b3b3b3", "subnet-0b3b3b3b3b3b3b3b", "subnet-0b3b3b3b3b3b3b3b3"]

}


variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "ip_family" {
  description = "The IP family for the EKS cluster. Valid values are `ipv4` and `dualstack`"
  type        = string
  default     = "ipv4" # Valid values are ipv4 (default) and ipv6. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created.
}

# The 3 variables below are used to enable/disable features in the EKS cluster (fully manged mode) and must be all false/true
variable "enable_elb" {
  description = "Indicates whether or not the Amazon EKS cluster should support the AWS Load Balancer Controller"
  type        = bool
  default     = false
  
}

variable "enable_ebs" {
  description = "Indicates whether or not the Amazon EKS cluster should support EBS storage"
  type        = bool
  default     = false
}

variable "enable_compute_type" {
  description = "Indicates whether or not the Amazon EKS cluster should support Fargate"
  type        = bool
  default     = false
  
}