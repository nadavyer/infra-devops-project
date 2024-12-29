output "vpn_server_ip" {
  description = "The public IP address of the VPN server"
  value       = aws_eip.vpn_eip.public_ip
}

output "vpn_security_group_id" {
  description = "The ID of the VPN security group"
  value       = aws_security_group.vpn_sg.id
}
