output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for s in aws_subnet.private_subnet : s.id]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for s in aws_subnet.private_subnet : s.id]
}