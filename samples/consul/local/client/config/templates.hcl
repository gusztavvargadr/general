vault {
  renew_token = false
}

template {
  source = "./consul.hcl"
  destination = "./config/consul.hcl"
  perms = 0600
}
