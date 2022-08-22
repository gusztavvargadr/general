resource "local_file" "server_config" {
  filename = "${local.artifacts_path}server/server.hcl"
  content  = file("${path.module}/server_config.hcl")
}

resource "local_file" "server_cert" {
  filename = "${local.artifacts_path}server/server.crt"
  content  = "${local.server_cert_pem}${local.ca_cert_pem}"
}

resource "local_sensitive_file" "server_private_key" {
  filename = "${local.artifacts_path}server/server.key"
  content  = local.server_private_key_pem
}
