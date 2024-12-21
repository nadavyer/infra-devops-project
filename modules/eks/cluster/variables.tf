variable "cluster_name" {
  description = "The name of the project"
  type        = string
  default     = "nadav-project"
}

variable "eks_version" {
  description = "The desired Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
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
