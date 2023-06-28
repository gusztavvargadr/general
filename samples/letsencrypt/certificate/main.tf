locals {
  acme_server_url = var.acme_server_url

  account_private_key = var.account_private_key

  certificate_common_name = var.certificate_common_name
  certificate_dns_challenge_provider = var.certificate_dns_challenge_provider
}

provider "acme" {
  server_url = local.acme_server_url
}

resource "acme_certificate" "certificate" {
  account_key_pem = local.account_private_key
  common_name = local.certificate_common_name

  dns_challenge {
    provider = local.certificate_dns_challenge_provider
  }
}

locals {
  certificate_id = acme_certificate.certificate.id
  certificate_ca_cert = acme_certificate.certificate.issuer_pem
  certificate_cert = acme_certificate.certificate.certificate_pem
  certificate_key = acme_certificate.certificate.private_key_pem
}
