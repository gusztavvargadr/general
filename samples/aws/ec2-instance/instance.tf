locals {
  ami_owners = ["099720109477"]
  ami_names  = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
}

data "aws_ami" "core" {
  owners      = local.ami_owners
  most_recent = true

  filter {
    name   = "name"
    values = local.ami_names
  }
}

locals {
  instance_options = {
    name               = local.deployment.name
    ami                = data.aws_ami.core.id
    type               = "t3.nano"
    volume_type        = "gp3"
    volume_size        = 8
    user               = "ubuntu"
    user_data_filename = "${path.root}/userdata.sh"
  }
}

resource "aws_instance" "default" {
  ami                    = local.instance_options.ami
  instance_type          = local.instance_options.type
  subnet_id              = local.network.subnet_ids[0]
  vpc_security_group_ids = [local.security_group.id]
  key_name               = local.ssh_key.name
  user_data              = file(local.instance_options.user_data_filename)

  ebs_optimized = true
  root_block_device {
    volume_type = local.instance_options.volume_type
    volume_size = local.instance_options.volume_size
  }

  tags = {
    Name = local.instance_options.name
  }

  volume_tags = {
    Name = local.instance_options.name
  }
}

locals {
  instance = {
    id   = aws_instance.default.id
    name = local.instance_options.name
    ip   = aws_instance.default.public_ip
    user = local.instance_options.user
  }
}

output "instance" {
  value = local.instance
}
