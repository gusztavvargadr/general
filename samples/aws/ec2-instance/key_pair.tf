locals {
  key_pair_name = local.deployment_name
}

resource "tls_private_key" "core" {
  algorithm = "RSA"
}

resource "aws_key_pair" "core" {
  key_name   = local.key_pair_name
  public_key = tls_private_key.core.public_key_openssh

  tags = {
    Name = local.key_pair_name
  }
}

resource "local_file" "key_pair_public_key" {
  filename = "${path.root}/.ssh/${local.key_pair_name}.pub"
  content  = tls_private_key.core.public_key_openssh
}

resource "local_sensitive_file" "key_pair_private_key" {
  filename = "${path.root}/.ssh/${local.key_pair_name}"
  content  = tls_private_key.core.private_key_pem
}

locals {
  key_pair_public_key_filename  = local_file.key_pair_public_key.filename
  key_pair_private_key_filename = local_sensitive_file.key_pair_private_key.filename
}
