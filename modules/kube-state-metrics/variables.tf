variable "namespace" {
  description = "The namespace to install kube-state-metrics into."
  type        = string
  default     = "kube-system"
}