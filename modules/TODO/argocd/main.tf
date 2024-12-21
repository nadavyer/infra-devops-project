resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

# data "aws_ssm_parameter" "git_repo_deploy_key" {
#   provider        = aws.us_east_1 # Specify the provider alias
#   name            = "/devops/argocd/helm-ingress-domains-deploy-key"
#   with_decryption = true
# }

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      k8s_version         = var.k8s_version
      replicas            = var.replicas
      server_service_type = var.server_service_type
      server_insecure     = true
      git_repo_url        = var.git_repo_url
    })
  ]

  wait    = true
  timeout = 600

  depends_on = [kubernetes_namespace.argocd]
}