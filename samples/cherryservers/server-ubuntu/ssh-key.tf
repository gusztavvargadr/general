module "core_ssh_key_tls" {
  source = "../../../src/core/ssh-key-tls"
}

locals {
  ssh_key_public  = trimspace(module.core_ssh_key_tls.public)
  ssh_key_private = trimspace(module.core_ssh_key_tls.private)
}

output "ssh_key_public" {
  value = local.ssh_key_public
}

output "ssh_key_private" {
  value     = local.ssh_key_private
  sensitive = true
}

locals {
  ssh_key_name = "${local.deployment}-ssh-key"
}

module "cherryservers_ssh_key" {
  source = "../../../src/cherryservers/ssh-key-cherryctl"

  name = local.ssh_key_name
  public = local.ssh_key_public
}

locals {
  ssh_key_id = module.cherryservers_ssh_key.id
}

output "ssh_key_id" {
  value = local.ssh_key_id
}

output "ssh_key_name" {
  value = local.ssh_key_name
}
