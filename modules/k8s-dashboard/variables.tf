variable "k8s_dashboard_namespace" {
  description = "The namespace to install the Kubernetes Dashboard into"
  default     = "kube-system"
}

variable "dashboard_version" {
  description = "The version of the Kubernetes Dashboard to install"
  default     = "7.7.0"
}

variable "ingress_host" {
  description = "The host name to use for the Ingress"
}

variable "ingress_class_name" {
  description = "The Ingress class name to use for the Ingress"
  default     = "nginx"

}