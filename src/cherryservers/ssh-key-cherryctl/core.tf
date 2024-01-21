variable "name" {
  type = string
}

variable "public" {
  type = string
}

locals {
  name        = var.name
  public      = var.public
}

resource "terraform_data" "core" {
  triggers_replace = [
    local.name,
    local.public,
  ]

  provisioner "local-exec" {
    command = format(
      "cherryctl ssh-key create --label %v --key '%v' --output json > %v",
      local.name,
      local.public,
      "${path.root}/.terraform/${self.id}.json",
    )
  }

  provisioner "local-exec" {
    command = format(
      "cherryctl ssh-key delete --ssh-key-id $(jq -r .id %v) --force",
      "${path.root}/.terraform/${self.id}.json",
    )
    when    = destroy
  }

  provisioner "local-exec" {
    command = format(
      "rm --force %v",
      "${path.root}/.terraform/${self.id}.json",
    )
    when    = destroy
  }
}

locals {
  id = trimspace(jsondecode(file("${path.root}/.terraform/${terraform_data.core.id}.json")).id)
}

output "id" {
  value = local.id
}
