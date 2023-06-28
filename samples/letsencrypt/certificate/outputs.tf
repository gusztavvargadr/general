output "certificate_id" {
  value = local.certificate_id
}

output "certificate_ca_cert" {
  value = local.certificate_ca_cert
}

output "certificate_cert" {
  value = local.certificate_cert
}

output "certificate_key" {
  value     = local.certificate_key
  sensitive = true
}
