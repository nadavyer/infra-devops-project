# infra-devops-project

### Update kubeconfig
```bash
aws eks update-kubeconfig --region us-east-2 --name nadav-proj-cluster --kubeconfig /tmp/kubeconfig-nadav-proj-cluster
```


### TODO list:
1. Nodes on EC2 dashboard should get tag Name from the asg
2. Providers Kubernetes and Helm can't work before cluster is created because of Kubeconfig on provider with is required
3. Make dashboard work with security token
4. Implement awsautoscaler helm chart module
5. Implement cert-manager with some free domain
6. Implement carpenter helm Module
7. Make argocd work with PVC
8. Implement Grafana