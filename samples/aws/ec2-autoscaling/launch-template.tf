locals {
  ami_options = {
    name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    user = "ubuntu"
  }
}

module "ami" {
  source = "../../../src/aws/ec2-ami-data"

  ami = local.ami_options
}

locals {
  ami = module.ami.ami
}

module "ssh_key" {
  source = "../../../src/core/ssh-key"
}

locals {
  launch_template_options = {
    ami_id             = local.ami.id

    vpc_id = local.vpc.id

    public_key = module.ssh_key.ssh_key.public
    user_data = file("${path.root}/userdata.sh")
  }
}

module "launch_template" {
  source = "../../../src/aws/ec2-launch-template"

  deployment      = local.deployment
  launch_template = local.launch_template_options
}

locals {
  launch_template = module.launch_template.launch_template
  security_group = module.launch_template.security_group
  iam = module.launch_template.iam
}

output "launch_template" {
  value = local.launch_template
}

output "security_group" {
  value = local.security_group
}

output "iam" {
  value = local.iam
}
