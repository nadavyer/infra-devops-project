output "cluster_ca_thumbprint" {
  description = "The certificate authority thumbprint of the EKS cluster"
  value       = aws_eks_cluster.main.certificate_authority.0.data
}

output "cluster_oidc_url" {
  description = "The OIDC issuer URL of the EKS cluster"
  value       = aws_eks_cluster.main.identity.0.oidc.0.issuer
}

data "aws_caller_identity" "current" {}

output "account_id" {
  description = "The AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "oidc_provider_url" {
  description = "The OIDC issuer URL of the EKS cluster"
  value       = aws_eks_cluster.main.identity.0.oidc.0.issuer
}

output "asg_name" {
  description = "The name of the Auto Scaling Group created for the EKS node group"
  value       = aws_eks_node_group.main.resources[0].autoscaling_groups[0].name
}

