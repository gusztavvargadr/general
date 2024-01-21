variable "algorithm" {
  type    = string
  default = "RSA"
}

locals {
  algorithm   = var.algorithm
}

resource "tls_private_key" "core" {
  algorithm = local.algorithm
}

locals {
  public  = trimspace(tls_private_key.core.public_key_openssh)
  private = trimspace(tls_private_key.core.private_key_pem)
}

output "public" {
  value = local.public
}

output "private" {
  value     = local.private
  sensitive = true
}
