variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the VPN server in"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the VPN server instance"
  type        = string
  default     = "ami-0ac73f33a1888c64a" # Ubuntu 18.04 LTS (example, ensure valid in your region)
}

variable "instance_type" {
  description = "The instance type for the VPN server"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}
