variable "name" {
  default = "prometheus"
}

variable "namespace" {
  default = ""
}

variable "chart_version" {
  default = "15.17.0"
}

variable "cluster_full_name" {
  default = ""
}

variable "node_selector" {
  default = "internal-services"
}

variable "affinity" {
  type    = bool
  default = false
}

variable "tolerations" {
  type    = bool
  default = false
}

variable "efs_name" {
  default = ""
}

variable "alertmanager_data_pvc_name" {
  default = "prometheus-alertmanager-data"
}

variable "alertmanager_data_pvc_size" {
  default = "2Gi"
}

variable "server_data_pvc_name" {
  default = "prometheus-server-data"
}

variable "server_data_pvc_size" {
  default = "8Gi"
}

variable "ingress_class" {
  default = "nginx-internal"
}

variable "server_hostname" {
  default = ""
}

variable "server_cpu_requests" {
  default = "500m"
}

variable "server_cpu_limits" {
  default = "1000m"
}

variable "server_memory_requests" {
  default = "3Gi"
}

variable "server_memory_limits" {
  default = "4Gi"
}

variable "extraScrapeConfigs" {
  default = false
}

variable "extraScrapeConfigsRegistry" {
  default = false
}