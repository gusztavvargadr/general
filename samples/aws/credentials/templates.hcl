vault {
  renew_token = false
}

template {
  source = "./env.sh.template"
  destination = "./artifacts/env.sh"
  perms = 0600
}
