output "asg_name" {
  description = "The name of the Auto Scaling Group created for the EKS node group"
  value       = aws_eks_node_group.main.resources[0].autoscaling_groups[0].name
}

output "nodegroup_name" {
  description = "The name of the EKS node group"
  value       = aws_eks_node_group.main.node_group_name
}
