locals {
  ssh_key_name = local.deployment_name
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
}

locals {
  ssh_key_public  = trimspace(tls_private_key.ssh_key.public_key_openssh)
  ssh_key_private = trimspace(tls_private_key.ssh_key.private_key_pem)
}

resource "terraform_data" "ssh_key" {
  triggers_replace = [
    local.ssh_key_name,
    local.ssh_key_public,
  ]

  provisioner "local-exec" {
    command = format(
      "cherryctl ssh-key create --label %v --key '%v' --output json | jq -r .id | tee ${path.root}/.terraform/ssh-key-id-${self.id}",
      local.ssh_key_name,
      local.ssh_key_public,
    )
  }

  provisioner "local-exec" {
    command = "cherryctl ssh-key delete --ssh-key-id $(cat ${path.root}/.terraform/ssh-key-id-${self.id}) --force"
    when    = destroy
  }

  provisioner "local-exec" {
    command = "rm ${path.root}/.terraform/ssh-key-id-${self.id}"
    when    = destroy
  }
}

locals {
  ssh_key_id = trimspace(file("${path.root}/.terraform/ssh-key-id-${terraform_data.ssh_key.id}"))
}

output "ssh_key_id" {
  value = local.ssh_key_id
}

output "ssh_key_name" {
  value = local.ssh_key_name
}

output "ssh_key_public" {
  value = local.ssh_key_public
}

output "ssh_key_private" {
  value     = local.ssh_key_private
  sensitive = true
}
