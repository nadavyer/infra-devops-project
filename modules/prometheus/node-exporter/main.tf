# https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus

resource "helm_release" "node_exporter" {
  name       = var.name
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-node-exporter"
  version    = var.chart_version


  values = [
    <<-EOT
prometheus:
  monitor:
    enabled: false
    additionalLabels: {}
    namespace: ${var.namespace}

resources:
   limits:
     cpu: 200m
     memory: 50Mi
   requests:
     cpu: 100m
     memory: 30Mi

%{~if var.affinity}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
          - key: "kops.k8s.io/instancegroup"
            operator: In
            values:
            - ${var.node_selector}
%{~endif}

nodeSelector:
  kops.k8s.io/instancegroup: ${var.node_selector}

%{~if var.tolerations}
tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: ${var.node_selector}
    effect: "NoSchedule"
%{~endif}

namespaceOverride: ${var.namespace}

EOT
  ]
}