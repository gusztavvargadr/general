locals {
  default_security_group_name = local.default_component_name
}

data "http" "local_ip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  local_ip = trimspace(data.http.local_ip.body)
}

resource "aws_security_group" "default" {
  name = local.default_security_group_name
  description = local.default_security_group_name
  vpc_id = local.default_vpc_id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${local.local_ip}/32"]
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
    Name = local.default_security_group_name
  }
}

locals {
  default_security_group_id = aws_security_group.default.id
}
