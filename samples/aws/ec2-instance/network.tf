locals {
  vpc_name = "default"
}

data "aws_vpc" "default" {
  tags = {
    Name = local.vpc_name
  }
}

data "aws_subnets" "public" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.default.id ]
  }

  filter {
    name = "tag:Name"
    values = [ "*public*" ]
  }
}

locals {
  default_vpc_id = data.aws_vpc.default.id
  public_subnet_ids = data.aws_subnets.public.ids
}
