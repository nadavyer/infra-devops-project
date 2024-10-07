# https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus

resource "helm_release" "fluent-bit" {
  name       = var.name
  namespace  = var.namespace
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = var.chart_version


  values = [
    <<-EOT
image:
  repository: cr.fluentbit.io/fluent/fluent-bit
  # Overrides the image tag whose default is {{ .Chart.AppVersion }}
  tag: "2.0.6"
  pullPolicy: Always
%{~if var.resources}
resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
%{~endif}
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


logLevel: ${var.log_level}

config:
  ## https://docs.fluentbit.io/manual/pipeline/inputs
  inputs: |
    [INPUT]
        Name tail
        Exclude_Path /var/log/containers/*_kube-system_*,/var/log/containers/*_${var.namespace}_*
        Path /var/log/containers/*.log
        Parser docker
        Tag kube.*
        Mem_Buf_Limit 10MB
        Skip_Long_Lines Off

  ## https://docs.fluentbit.io/manual/pipeline/parsers
  parsers: |
    [PARSER]
        Name        docker
        Format      json
        Time_Key    time
        Time_Format %Y-%m-%dT%H:%M:%S
        Time_Keep   On

  ## https://docs.fluentbit.io/manual/pipeline/filters
  filters: |
    [FILTER]
        Name kubernetes
        Match kube.*
        Merge_Log On
        Keep_Log Off
        K8S-Logging.Parser On
        K8S-Logging.Exclude On
        Labels Off
        Annotations Off

    [FILTER]
        Name nest
        Match kube.*
        Operation lift
        Nested_under kubernetes
        Add_prefix kubernetes_

    [FILTER]
        Name modify
        Match kube.*
        Remove kubernetes_container_hash
        Remove kubernetes_container_image
        Remove kubernetes_docker_id
        Remove kubernetes_pod_id
        Remove stream

  ## https://docs.fluentbit.io/manual/pipeline/outputs
  outputs: |
    [OUTPUT]
        Name       es
        Match      kube.*
        Host       ${var.opensearch_endpoint}
        Port       ${var.opensearch_port}
        AWS_Region ${var.region}
        tls        On
        Index      fluent-bit
        Logstash_Format True
        Logstash_DateFormat %Y-%m-%d
        Logstash_Prefix airflow-pod-operator

  EOT
  ]
}