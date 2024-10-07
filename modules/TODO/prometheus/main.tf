# https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus

resource "helm_release" "prometheus" {
  name       = var.name
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = var.chart_version


  values = [<<-EOT

%{if var.extraScrapeConfigs}
extraScrapeConfigs: |
%{endif}
%{if var.extraScrapeConfigsRegistry != ""~}
${var.extraScrapeConfigsRegistry}
%{endif~}
alertmanager:
  enabled: false
%{~if var.tolerations}
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: ${var.node_selector}
    effect: "NoSchedule"
%{~endif}
  nodeSelector:
    kops.k8s.io/instancegroup: ${var.node_selector}
%{~if var.affinity}
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "kops.k8s.io/instancegroup"
            operator: In
            values: [ ${var.node_selector} ]
%{~endif}
  existingClaim: ${var.alertmanager_data_pvc_name}
  size: ${var.alertmanager_data_pvc_size}
  storageClass: ${var.efs_name}
  resources:
    limits:
      cpu: 100m
      memory: 320Mi
    requests:
      cpu: 50m
      memory: 100Mi


kubeStateMetrics:
  enabled: true
kube-state-metrics:
%{~if var.tolerations}
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: ${var.node_selector}
    effect: "NoSchedule"
%{~endif}
  collectors:
    - daemonsets
    - deployments
    - horizontalpodautoscalers
    - ingresses
    - limitranges
    - namespaces
    - nodes
    - pods
    - replicasets
    - replicationcontrollers
    - resourcequotas
    - services
    - statefulsets

  nodeSelector:
    kops.k8s.io/instancegroup: ${var.node_selector}
%{~if var.affinity}
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "kops.k8s.io/instancegroup"
            operator: In
            values: [ ${var.node_selector} ]
%{~endif}
nodeExporter:
  enabled: false

server:
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: "${var.ingress_class}"
      nginx.ingress.kubernetes.io/proxy-connect-timeout: "30"
      nginx.ingress.kubernetes.io/proxy-read-timeout: "180"
      nginx.ingress.kubernetes.io/proxy-send-timeout: "180"

    extraLabels:
      app.kubernetes.io/name: "${var.name}-server"

    hosts:
      - "${var.server_hostname}"
    path: /
    tls:
    - secretName: naturalint.com
      hosts:
        - "*.naturalint.com"

  %{~if var.tolerations}
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: ${var.node_selector}
    effect: "NoSchedule"
%{~endif}
  nodeSelector:
    kops.k8s.io/instancegroup: ${var.node_selector}
%{~if var.affinity}
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "kops.k8s.io/instancegroup"
            operator: In
            values: [ ${var.node_selector} ]
%{~endif}
  persistentVolume:
    enabled: true
    existingClaim: ${var.server_data_pvc_name}
    size: ${var.server_data_pvc_size}
  resources:
    limits:
      cpu: ${var.server_cpu_limits}
      memory: ${var.server_memory_limits}
    requests:
      cpu: ${var.server_cpu_requests}
      memory: ${var.server_memory_requests}

pushgateway:
  enabled: false
  name: pushgateway
  %{~if var.tolerations}
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: ${var.node_selector}
    effect: "NoSchedule"
%{~endif}
  nodeSelector:
    kops.k8s.io/instancegroup: ${var.node_selector}
  ## Pod affinity
  ##
%{~if var.affinity}
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "kops.k8s.io/instancegroup"
            operator: In
            values: [ ${var.node_selector} ]
%{~endif}
  resources:
    limits:
      cpu: 100m
      memory: 320Mi
    requests:
      cpu: 50m
      memory: 100Mi

  scrape_interval: 15s
  scrape_timeout: 10s

  EOT
  ]

}