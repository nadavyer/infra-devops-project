variable "kubeconfig" {
  description = "The path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "Namespace where ArgoCD will be installed"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Helm chart version for ArgoCD"
  type        = string
  default     = "7.5.2"
}

variable "replicas" {
  description = "Number of replicas for ArgoCD application controllers"
  type        = number
  default     = 3
}

variable "server_service_type" {
  description = "Service type for ArgoCD server"
  type        = string
  default     = "ClusterIP"
}