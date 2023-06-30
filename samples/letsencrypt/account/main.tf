locals {
  server_url = var.server_url

  account_private_key_algorithm = var.account_private_key_type
  account_email_address         = var.account_email_address
}

provider "acme" {
  server_url = local.server_url
}

resource "tls_private_key" "account" {
  algorithm = local.account_private_key_algorithm
}

resource "acme_registration" "account" {
  account_key_pem = tls_private_key.account.private_key_pem
  email_address   = local.account_email_address
}

locals {
  account_id          = acme_registration.account.id
  account_public_key  = tls_private_key.account.public_key_pem
  account_private_key = acme_registration.account.account_key_pem
}
