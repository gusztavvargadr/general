locals {
  network_options = {
    vpc_name = "default"
  }
}

data "aws_vpc" "default" {
  tags = {
    Name = local.network_options.vpc_name
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

locals {
  network = {
    vpc_id     = data.aws_vpc.default.id
    subnet_ids = data.aws_subnets.default.ids
  }
}

output "network" {
  value = local.network
}
