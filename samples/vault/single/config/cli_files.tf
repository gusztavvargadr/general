resource "local_file" "cli_cert" {
  filename = "${local.artifacts_path}cli/ca.crt"
  content  = local.ca_cert_pem
}
