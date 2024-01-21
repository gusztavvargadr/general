output "certificate_id" {
  value = local.certificate_id
}

output "certificate_ca_cert" {
  value = local.certificate_ca_cert
}

output "certificate_server_cert" {
  value = local.certificate_server_cert
}

output "certificate_server_key" {
  value     = local.certificate_server_key
  sensitive = true
}
