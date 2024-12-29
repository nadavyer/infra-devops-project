# infra-devops-project

### Create infra
1. Run vpc, eks, nodegroup modules:
```bash
terraform apply -target=module.vpc -target=module.eks -target=module.eks_nodegroup
```
2. Generate kubeconfig (as seen below) and set it in desired path. Then update variable kubeconfig_path
3. 


### Update kubeconfig
```bash
aws eks update-kubeconfig --region us-east-2 --name nadav-proj-cluster --kubeconfig /tmp/kubeconfig-nadav-proj-cluster
```



### Destroy env:
1. Run revert order of modules
```bash
terraform destroy -target=module.vpc -target=module.eks -target=module.eks_nodegroup
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