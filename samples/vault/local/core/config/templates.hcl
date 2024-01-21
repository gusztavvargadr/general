vault {
  renew_token = false
}

template {
  source = "./vault.hcl"
  destination = "./config/vault.hcl"
  perms = 0600
}
