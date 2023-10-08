variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "plan" {
  type    = string
}

variable "image" {
  type    = string
}

variable "ssh_keys" {
  type = string
}

variable "userdata" {
  type    = string
  default = ""
}

variable "spot" {
  type    = bool
  default = false
}

locals {
  name     = var.name
  region   = var.region
  plan     = var.plan
  image    = var.image
  ssh_keys = var.ssh_keys
  userdata = var.userdata
  spot     = var.spot
}

resource "terraform_data" "core" {
  triggers_replace = [
    local.name,
    local.region,
    local.plan,
    local.image,
    local.ssh_keys,
    local.userdata,
    local.spot,
  ]

  provisioner "local-exec" {
    command = format(
      "cherryctl server create --hostname %v --region %v --plan %v --image %v --ssh-keys %v %v %v --output json > %v",
      local.name,
      local.region,
      local.plan,
      local.image,
      local.ssh_keys,
      local.userdata != "" ? "--userdata-file ${local.userdata} " : "",
      local.spot ? "--spot-instance" : "",
      "${path.root}/.terraform/${self.id}.json",
    )
  }

  provisioner "local-exec" {
    command = format(
      "cherryctl server delete $(jq -r .id %v) --force",
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

resource "terraform_data" "state" {
  triggers_replace = [
    local.id,
  ]

  provisioner "local-exec" {
    command = format(
      "while true; do cherryctl server get %v --output json > %v; STATE=$(jq -r .state %v); if [ $STATE = 'active' ]; then break; fi; sleep 5; done",
      local.id,
      "${path.root}/.terraform/${self.id}.json",
      "${path.root}/.terraform/${self.id}.json",
    )
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
  ip = trimspace(jsondecode(file("${path.root}/.terraform/${terraform_data.state.id}.json")).ip_addresses[0].address)
}

output "id" {
  value = local.id
}

output "ip" {
  value = local.ip
}
