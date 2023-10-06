variable "instance_plan" {
  type    = string
  default = "cloud_vps_1"
}

variable "instance_image" {
  type    = string
  default = "ubuntu_20_04"
}

variable "instance_spot" {
  type    = bool
  default = false
}

variable "instance_userdata" {
  type    = string
  default = ""
}

locals {
  instance_region = local.region_name
  instance_name   = local.deployment_name

  instance_plan     = var.instance_plan
  instance_image    = var.instance_image
  instance_spot     = var.instance_spot
  instance_userdata = var.instance_userdata
  instance_ssh_keys = local.ssh_key_id
}

resource "terraform_data" "instance" {
  triggers_replace = [
    local.instance_region,
    local.instance_name,

    local.instance_plan,
    local.instance_image,
    local.instance_spot,
    local.instance_userdata,
    local.instance_ssh_keys,
  ]

  provisioner "local-exec" {
    command = format(
      "cherryctl server create --region %v --hostname %v --plan %v --image %v %v %v --ssh-keys %v --output json | jq -r .id | tee ${path.root}/.terraform/instance-id-${self.id}",
      local.instance_region,
      local.instance_name,
      local.instance_plan,
      local.instance_image,
      local.instance_spot ? "--spot-instance" : "",
      local.instance_userdata != "" ? "--userdata-file ${local.instance_userdata} " : "",
      local.instance_ssh_keys,
    )
  }

  provisioner "local-exec" {
    command = "cherryctl server delete $(cat ${path.root}/.terraform/instance-id-${self.id}) --force"
    when    = destroy
  }

  provisioner "local-exec" {
    command = "rm ${path.root}/.terraform/instance-id-${self.id}"
    when    = destroy
  }
}

locals {
  instance_id = trimspace(file("${path.root}/.terraform/instance-id-${terraform_data.instance.id}"))
}

resource "terraform_data" "instance_state" {
  triggers_replace = [
    local.instance_id,
  ]

  provisioner "local-exec" {
    command = format(
      "while true; do STATE=$(cherryctl server get %v --output json | jq -r .state | tee ${path.root}/.terraform/instance-state-${self.id}); echo $STATE; if [ $STATE = 'active' ]; then break; fi; sleep 5; done",
      local.instance_id,
    )
    interpreter = [
      "/bin/bash",
      "-c",
    ]
  }

  provisioner "local-exec" {
    command = "rm ${path.root}/.terraform/instance-state-${self.id}"
    when    = destroy
  }
}

resource "terraform_data" "instance_ip" {
  triggers_replace = [
    terraform_data.instance_state.id,
  ]

  provisioner "local-exec" {
    command = format(
      "cherryctl server get %v --output json | jq -r .ip_addresses[0].address | tee ${path.root}/.terraform/instance-ip-${self.id}",
      local.instance_id,
    )
  }

  provisioner "local-exec" {
    command = "rm ${path.root}/.terraform/instance-ip-${self.id}"
    when    = destroy
  }
}

locals {
  instance_ip = trimspace(file("${path.root}/.terraform/instance-ip-${terraform_data.instance_ip.id}"))
}

output "instance_id" {
  value = local.instance_id
}

output "instance_name" {
  value = local.instance_name
}

output "instance_ip" {
  value = local.instance_ip
}
