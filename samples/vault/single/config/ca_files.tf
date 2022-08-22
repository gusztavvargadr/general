resource "local_file" "ca_cert" {
  filename = "${local.artifacts_path}ca/ca.crt"
  content  = local.ca_cert_pem
}

resource "local_sensitive_file" "ca_private_key" {
  filename = "${local.artifacts_path}ca/ca.key"
  content  = local.ca_private_key_pem
}
