variable "kubeconfig" {
  description = "The path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "k8s_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "1.30"

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
  default     = 1
}

variable "server_service_type" {
  description = "Service type for ArgoCD server"
  type        = string
  default     = "ClusterIP"
}

variable "server_insecure" {
  description = "Whether to disable TLS verification for the ArgoCD server"
  type        = bool
  default     = true
}

variable "git_repo_url" {
  description = "URL of the Git repository to be used by ArgoCD"
  type        = string

}
