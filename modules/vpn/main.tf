resource "aws_security_group" "vpn_sg" {
  name        = "${var.project_name}-vpn-sg"
  description = "Security group for VPN server"
  vpc_id      = var.vpc_id

  # Port 1194 for OpenVPN UDP
  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 943 for OpenVPN AS Web UI
  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 443 for OpenVPN AS Web and Admin UI
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-vpn-sg"
  }
}

resource "aws_instance" "vpn_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.vpn_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = "${var.project_name}-vpn-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get -y install openvpn
              wget https://openvpn.net/downloads/openvpn-as-latest-ubuntu18.amd_64.deb
              dpkg -i openvpn-as-latest-ubuntu18.amd_64.deb
              # Set the default password for the 'openvpn' user
              echo "openvpn:changeme" | chpasswd
              ufw allow 943/tcp
              ufw allow 443/tcp
              ufw allow 1194/udp
              EOF
}

resource "aws_eip" "vpn_eip" {
  instance                  = aws_instance.vpn_server.id
  associate_with_private_ip = aws_instance.vpn_server.private_ip
  tags = {
    Name = "${var.project_name}-vpn-eip"
  }
}