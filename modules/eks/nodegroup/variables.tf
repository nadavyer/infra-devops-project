variable "cluster_name" {
  description = "The name of the project"
  type        = string
  default     = "nadav-project"
}

variable "ami_type" {
  description = "The type of the AMI"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "ng_name_suffix" {
  description = "The suffix for the node group name"
  type        = string
  default     = "ng"

}

variable "node_name_suffix" {
  description = "The suffix for the node name"
  type        = string
  default     = "node"
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

variable "node_group_instance_type" {
  description = "The instance type for the worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_group_desired_size" {
  description = "The desired number of worker nodes"
  type        = number
  default     = 2

}

variable "ignore_desired_size_changes" {
  description = "Whether to ignore changes to the desired size - useful for managing the desired size outside of Terraform e.g. with cluster-autoscaler"
  type        = bool
  default     = false

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

variable "capacity_type" {
  description = "The capacity type for the worker nodes"
  type        = string
  default     = "SPOT" # | "ON_DEMAND"

}

variable "node_group_disk_size" {
  description = "The disk size for the worker nodes"
  type        = number
  default     = 20

}