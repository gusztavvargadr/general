locals {
  server_common_name = "${local.server_name}.${local.ca_name}"

  server_private_key_algorithm = "RSA"
  server_validity_period_hours = 24 * 365 * 1
}

resource "tls_private_key" "server" {
  algorithm = local.server_private_key_algorithm
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name = local.server_common_name
  }

  dns_names    = ["localhost", "vault"]
  ip_addresses = ["127.0.0.1"]
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_cert_pem        = local.ca_cert_pem
  ca_private_key_pem = local.ca_private_key_pem

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "key_agreement",
    "server_auth",
    "client_auth"
  ]

  validity_period_hours = local.server_validity_period_hours
}

locals {
  server_cert_pem        = tls_locally_signed_cert.server.cert_pem
  server_private_key_pem = tls_private_key.server.private_key_pem
}
