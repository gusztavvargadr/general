locals {
  ami_owners = ["099720109477"]
  ami_names = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}

data "aws_ami" "core" {
  owners = local.ami_owners
  most_recent = true

  filter {
    name = "name"
    values = local.ami_names
  }
}

locals {
  ami_id = data.aws_ami.core.id
}
