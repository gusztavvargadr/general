locals {
  default_key_name = local.default_component_name
}

resource "tls_private_key" "default" {
  algorithm = "RSA"
}

resource "aws_key_pair" "default" {
  key_name = local.default_key_name
  public_key = tls_private_key.default.public_key_openssh

  tags = {
    Name = local.default_key_name
  }
}

resource "local_file" "public_key" {
  filename = "${path.root}/.ssh/${local.default_key_name}.pub"
  content = tls_private_key.default.public_key_openssh
}

resource "local_sensitive_file" "private_key" {
  filename = "${path.root}/.ssh/${local.default_key_name}"
  content = tls_private_key.default.private_key_pem
}

locals {
  public_key_filename = local_file.public_key.filename
  private_key_filename = local_sensitive_file.private_key.filename
}
