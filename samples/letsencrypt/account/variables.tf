variable "acme_server_url" {
  type    = string
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "account_private_key_type" {
  type    = string
  default = "RSA"
}

variable "account_email_address" {
  type = string
}
