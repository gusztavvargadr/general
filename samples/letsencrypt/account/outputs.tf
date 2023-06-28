output "account_id" {
  value = local.account_id
}

output "account_public_key" {
  value = local.account_public_key
}

output "account_private_key" {
  value     = local.account_private_key
  sensitive = true
}
