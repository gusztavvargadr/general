vault {
  renew_token = false
}

template {
  source = "./config.hcl"
  destination = "./artifacts/config/nomad.hcl"
}
