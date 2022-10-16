resource "local_file" "init_cert" {
  filename = "${local.artifacts_path}init/ca.crt"
  content  = local.ca_cert_pem
}
