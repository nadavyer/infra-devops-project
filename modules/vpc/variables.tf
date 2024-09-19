variable "project_name" {
  description = "The name of the project"
  type        = string
  default = "nadav-project"
}

variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default = "us-east-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
  default = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
  
}

variable "availability_zones" {
  description = "The availability zones to deploy into"
  type        = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}


