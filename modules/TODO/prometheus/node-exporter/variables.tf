variable "name" {
  default = ""
}

variable "namespace" {
  default = ""
}
variable "chart_version" {
  default = "4.5.0"
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

variable "tolerations" {
  type    = bool
  default = false
}



