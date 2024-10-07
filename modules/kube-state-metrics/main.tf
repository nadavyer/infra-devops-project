resource "helm_release" "kube_state_metrics" {
  repository = "https://prometheus-community.github.io/helm-charts"
  name       = "kube-state-metrics"
  chart      = "kube-state-metrics"
  version    = "5.25.1"
  namespace  = var.namespace

  set {
    name  = "fullnameOverride"
    value = "kube-state-metrics"
  }
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  namespace  = var.namespace
}