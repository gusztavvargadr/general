data "http" "local_ip" {
  url = "https://ifconfig.me"
}

locals {
  security_group_options = {
    name       = local.deployment.name
    ingress_ip = trimspace(data.http.local_ip.response_body)
  }
}

resource "aws_security_group" "default" {
  name   = local.security_group_options.name
  vpc_id = local.network.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.security_group_options.ingress_ip}/32"]
  }

  egress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = local.security_group_options.name
  }
}

locals {
  security_group = {
    id   = aws_security_group.default.id
    name = aws_security_group.default.name
  }
}

output "security_group" {
  value = local.security_group
}
