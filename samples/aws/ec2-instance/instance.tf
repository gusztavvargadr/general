locals {
  default_instance_name = local.default_component_name
  default_instance_type = "t3.micro"
  default_instance_user = "ubuntu"
}

resource "aws_instance" "default" {
  ami = local.default_ami_id
  instance_type = local.default_instance_type
  subnet_id = local.public_subnet_ids[0]
  vpc_security_group_ids = [ local.default_security_group_id ]
  key_name = local.default_key_name

  tags = {
    Name = local.default_instance_name
  }

  volume_tags = {
    Name = local.default_instance_name
  }

  connection {
    type     = "ssh"
    user     = local.default_instance_user
    private_key = file(local.private_key_filename)
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    script = "${path.module}/provision.sh"
  }
}

locals {
  default_instance_id = aws_instance.default.id
  default_instance_public_ip = aws_instance.default.public_ip
}