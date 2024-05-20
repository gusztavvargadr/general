module "vpc" {
  source = "../../../src/aws/vpc-data"
}

locals {
  vpc = module.vpc.vpc
}

output "vpc" {
  value = local.vpc
}

data "http" "local_ip" {
  url = "https://ifconfig.me"
}

locals {
  local_ip = trimspace(data.http.local_ip.response_body)
}

resource "aws_vpc_security_group_ingress_rule" "ipv4_ssh" {
  security_group_id = local.security_group.id

  ip_protocol = "tcp"
  cidr_ipv4   = "${local.local_ip}/32"
  from_port   = 22
  to_port     = 22

  tags = {
    Name = "ipv4-ssh"
  }
}

resource "aws_vpc_security_group_egress_rule" "ipv4_all" {
  security_group_id = local.security_group.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "ipv4-all"
  }
}
