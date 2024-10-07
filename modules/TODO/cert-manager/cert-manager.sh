helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1 \
  --set installCRDs=true


kubectl create secret -n cert-manager generic route53-dns-hosted-zone-credentials-secret  \
  --from-literal=secret-access-key=zxuYKnIXdE9I5P7tcIHXZBfez1dhKZajcQrwtYXE \
  --namespace cert-manager


