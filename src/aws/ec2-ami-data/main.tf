terraform {
  required_version = "~> 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }
  }
}

variable "ami_options" {
  type = object({
    owner = string
    name  = string
  })
}

locals {
  ami_options = var.ami_options
}

data "aws_ami" "default" {
  owners = [local.ami_options.owner]

  filter {
    name   = "name"
    values = [local.ami_options.name]
  }

  most_recent = true
}

locals {
  ami = {
    id   = data.aws_ami.default.id
    arn  = data.aws_ami.default.arn
    name = data.aws_ami.default.name
  }
}

output "ami" {
  value = local.ami
}
