locals {
  security_group_name = local.deployment_name
}

data "http" "local_ip" {
  url = "https://ifconfig.me"
}

locals {
  security_group_ingress_ip = trimspace(data.http.local_ip.body)
}

resource "aws_security_group" "core" {
  name   = local.security_group_name
  vpc_id = local.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.security_group_ingress_ip}/32"]
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
    Name = local.security_group_name
  }
}

locals {
  security_group_id = aws_security_group.core.id
}
