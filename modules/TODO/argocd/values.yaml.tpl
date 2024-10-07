global:
  domain: argocd.pg.naturalint.com

replicaCount: ${replicas}

server:
  service:
    type: ${server_service_type}


# Argo CD server ingress configuration
  ingress:
    enabled: true
    labels: {}
    annotations: 
      external-dns.alpha.kubernetes.io/target: internal-alb-int-playground-v1-27-3-eks-1554844771.us-east-2.elb.amazonaws.com
    ingressClassName: nginx-int-alb
    hostname: argocd.pg.naturalint.com
    path: /
    pathType: Prefix
    tls: false
