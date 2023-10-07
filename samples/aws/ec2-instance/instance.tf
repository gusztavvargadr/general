locals {
  instance_name        = local.deployment_name
  instance_type        = "t3.nano"
  instance_volume_type = "gp3"
  instance_volume_size = 8
  instance_user        = "ubuntu"
}

locals {
  ami_owners = ["099720109477"]
  ami_names  = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
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
  ami_id = data.aws_ami.core.id
}

resource "aws_instance" "core" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  subnet_id              = local.subnet_ids[0]
  vpc_security_group_ids = [local.security_group_id]
  key_name               = local.ssh_key_name
  # user_data              = file(local.instance_user_data_filename)

  ebs_optimized = true
  root_block_device {
    volume_type = local.instance_volume_type
    volume_size = local.instance_volume_size
  }

  tags = {
    Name = local.instance_name
  }

  volume_tags = {
    Name = local.instance_name
  }
}

locals {
  instance_id = aws_instance.core.id
  instance_ip = aws_instance.core.public_ip
}

output "instance_id" {
  value = local.instance_id
}

output "instance_ip" {
  value = local.instance_ip
}
