locals {
  default_instance_name = local.default_component_name
  default_instance_type = "t3.nano"
  default_instance_user = "ubuntu"
  default_instance_user_data_filename = "${path.module}/instance_user_data.sh"
  default_instance_provision_filename = "${path.module}/instance_provision.sh"
}

resource "aws_instance" "default" {
  ami = local.default_ami_id
  instance_type = local.default_instance_type
  subnet_id = local.public_subnet_ids[0]
  vpc_security_group_ids = [ local.default_security_group_id ]
  key_name = local.default_key_name
  user_data = file(local.default_instance_user_data_filename)

  connection {
    type     = "ssh"
    user     = local.default_instance_user
    private_key = file(local.private_key_filename)
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    script = local.default_instance_provision_filename
  }

  tags = {
    Name = local.default_instance_name
  }

  volume_tags = {
    Name = local.default_instance_name
  }
}

# resource "aws_spot_instance_request" "default" {
#   ami = local.default_ami_id
#   instance_type = local.default_instance_type
#   subnet_id = local.public_subnet_ids[0]
#   vpc_security_group_ids = [ local.default_security_group_id ]
#   key_name = local.default_key_name
#   user_data = file(local.default_instance_user_data_filename)

#   connection {
#     type     = "ssh"
#     user     = local.default_instance_user
#     private_key = file(local.private_key_filename)
#     host     = self.public_ip
#   }

#   provisioner "remote-exec" {
#     script = local.default_instance_provision_filename
#   }

#   spot_type = "one-time"

#   tags = {
#     Name = local.default_instance_name
#   }

#   volume_tags = {
#     Name = local.default_instance_name
#   }
# }

locals {
  default_instance_id = aws_instance.default.id
  default_instance_public_ip = aws_instance.default.public_ip
}

# locals {
#   default_instance_id = aws_spot_instance_request.default.id
#   default_instance_public_ip = aws_spot_instance_request.default.public_ip
# }
