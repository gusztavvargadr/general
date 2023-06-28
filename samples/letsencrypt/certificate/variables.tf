variable "acme_server_url" {
  type    = string
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "account_private_key" {
  type    = string
}

variable "certificate_common_name" {
  type = string
}

variable "certificate_dns_challenge_provider" {
  type = string
  default = "route53"
}
