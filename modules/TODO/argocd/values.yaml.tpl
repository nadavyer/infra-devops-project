global:
  domain: argocd.naturalint.com
  kubeVersionOverride: ${k8s_version}

certificate:
  enabled: false

redis-ha:
  enabled: false

controller:
  replicas: 1

repoServer:
  autoscaling:
    enabled: true
    minReplicas: 1

applicationSet:
  replicas: 1

server:
  insecure: true
  ingress:
    enabled: true
    annotations: {} 
      # external-dns.alpha.kubernetes.io/target: internal-alb-int-playground-v1-27-3-eks-1554844771.us-east-2.elb.amazonaws.com
    ingressClassName: nginx-int-alb
    tls: false

  autoscaling:
    enabled: true
    minReplicas: 1

  service:
    type: ${server_service_type}
    service:
      servicePortHttp: 80

configs:
  params:
    server.insecure: ${server_insecure}
