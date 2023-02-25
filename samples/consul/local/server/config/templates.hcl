vault {
  renew_token = false
}

template {
  source = "./consul.hcl"
  destination = "/tmp/consul/config/consul.hcl"
}
