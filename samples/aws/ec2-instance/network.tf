locals {
  vpc_name = "default"
}

data "aws_vpc" "core" {
  tags = {
    Name = local.vpc_name
  }
}

data "aws_subnets" "core" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.core.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

locals {
  vpc_id     = data.aws_vpc.core.id
  subnet_ids = data.aws_subnets.core.ids
}
