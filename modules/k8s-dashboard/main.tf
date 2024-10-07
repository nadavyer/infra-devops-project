resource "helm_release" "kubernetes_dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = var.dashboard_version
  namespace  = var.k8s_dashboard_namespace

  # set {
  #     name  = "ingress.enabled"
  #     value = "true"
  # }

  # set {
  #     name  = "ingress.ingressClassName"
  #     value = var.ingress_class_name
  # }

  # set {
  #     name  = "ingress.hosts[0]"
  #     value = var.ingress_host
  # }

  # set {
  #     name  = "ingress.path"
  #     value = "/k8s-dashboard"
  # }
}

resource "kubernetes_manifest" "dashboard" {
  manifest = yamldecode(templatefile("${path.module}/k8s-dashboard-ingress-resource.yaml", {
    namespace        = var.k8s_dashboard_namespace,
    ingressClassName = var.ingress_class_name,
    host             = var.ingress_host
  }))
  depends_on = [helm_release.kubernetes_dashboard]
}

resource "kubernetes_manifest" "serviceAccount" {
  manifest = yamldecode(templatefile("${path.module}/k8s-dashboard-sa.yaml", {
    namespace = var.k8s_dashboard_namespace
  }))
  depends_on = [helm_release.kubernetes_dashboard]
}

resource "kubernetes_manifest" "clusterRole" {
  manifest   = yamldecode(templatefile("${path.module}/k8s-dashboard-clusterrole.yaml", {}))
  depends_on = [helm_release.kubernetes_dashboard]
}

resource "kubernetes_manifest" "clusterRoleBinding" {
  manifest = yamldecode(templatefile("${path.module}/k8s-dashboard-clusterrolebinding.yaml", {
    namespace = var.k8s_dashboard_namespace
  }))
  depends_on = [helm_release.kubernetes_dashboard]
}