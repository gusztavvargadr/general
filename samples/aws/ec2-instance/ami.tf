locals {
  default_ami_owners = ["099720109477"]
  default_ami_names = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}

data "aws_ami" "default" {
  owners = local.default_ami_owners
  most_recent = true

  filter {
    name = "name"
    values = local.default_ami_names
  }
}

locals {
  default_ami_id = data.aws_ami.default.id
}
