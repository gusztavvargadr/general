locals {
  ssh_key_options = {
    name      = local.deployment.name
    algorithm = "RSA"
  }
}

resource "tls_private_key" "default" {
  algorithm = local.ssh_key_options.algorithm
}

resource "aws_key_pair" "default" {
  key_name   = local.ssh_key_options.name
  public_key = trimspace(tls_private_key.default.public_key_openssh)

  tags = {
    Name = local.ssh_key_options.name
  }
}

locals {
  ssh_key = {
    id      = aws_key_pair.default.id
    name    = aws_key_pair.default.key_name
    public  = aws_key_pair.default.public_key
    private = trimspace(tls_private_key.default.private_key_pem)
  }
}

output "ssh_key" {
  value     = local.ssh_key
  sensitive = true
}
