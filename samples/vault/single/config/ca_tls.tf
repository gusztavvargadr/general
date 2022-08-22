locals {
  ca_common_name = local.ca_name

  ca_private_key_algorithm = "RSA"
  ca_validity_period_hours = 24 * 365 * 10
}

resource "tls_private_key" "ca" {
  algorithm = local.ca_private_key_algorithm
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name = local.ca_common_name
  }

  allowed_uses = ["cert_signing"]

  validity_period_hours = local.ca_validity_period_hours

  is_ca_certificate = true
}

locals {
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
}
