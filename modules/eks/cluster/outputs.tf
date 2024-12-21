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

output "cluster_sg_id" {
  description = "The ID of the security group created by EKS for the cluster"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}