variable "name" {
  default = "fluent-bit"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "namespace" {
  default = ""
}

variable "chart_version" {
  default = "0.21.5"
}

variable "cluster_full_name" {
  default = ""
}

variable "node_selector" {
  default = ""
}

variable "affinity" {
  type    = bool
  default = false
}

variable "resources" {
  type    = bool
  default = true
}

variable "group" {
  default = ""
}

variable "podAffinity" {
  type    = bool
  default = false
}

variable "tolerations" {
  type    = bool
  default = false
}

variable "opensearch_endpoint" {
  type    = string
  default = ""
}

variable "opensearch_port" {
  type    = string
  default = "443"
}

variable "log_level" {
  type        = string
  description = "log level of fluent bit: debug, info, warn,error"
  default     = "info"
}

