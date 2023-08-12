locals {
  instance_name               = local.deployment_name
  instance_type               = "t3.nano"
  instance_volume_type        = "gp3"
  instance_volume_size        = 8
  instance_user               = "ubuntu"
  instance_user_data_filename = "${path.module}/instance_user_data.sh"
  instance_provision_filename = "${path.module}/instance_provision.sh"
}

resource "aws_instance" "core" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  subnet_id              = local.subnet_ids[0]
  vpc_security_group_ids = [local.security_group_id]
  key_name               = aws_key_pair.core.key_name
  user_data              = file(local.instance_user_data_filename)

  ebs_optimized = true
  root_block_device {
    volume_type = local.instance_volume_type
    volume_size = local.instance_volume_size
  }

  connection {
    type        = "ssh"
    user        = local.instance_user
    private_key = tls_private_key.core.private_key_pem
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    script = local.instance_provision_filename
  }

  tags = {
    Name = local.instance_name
  }

  volume_tags = {
    Name = local.instance_name
  }
}

locals {
  instance_id        = aws_instance.core.id
  instance_public_ip = aws_instance.core.public_ip
}
