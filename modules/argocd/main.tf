resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      replicas             = var.replicas
      server_service_type  = var.server_service_type
    })
  ]

  wait       = true
  timeout    = 600
}