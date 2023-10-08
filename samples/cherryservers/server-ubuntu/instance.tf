variable "instance_plan" {
  type    = string
  default = "cloud_vps_1"
}

variable "instance_image_version" {
  type    = string
  default = "20_04"
}

variable "instance_spot" {
  type    = bool
  default = false
}

locals {
  instance_name     = local.deployment
  instance_region   = local.region
  instance_plan     = var.instance_plan
  instance_image    = "ubuntu_${var.instance_image_version}"
  instance_ssh_keys = local.ssh_key_id
  # instance_userdata = "${path.root}/userdata.yml"
  instance_spot     = var.instance_spot
}

module "cherryservers_server" {
  source = "../../../src/cherryservers/server-cherryctl"

  name = local.instance_name
  region = local.instance_region
  plan = local.instance_plan
  image = local.instance_image
  ssh_keys = local.instance_ssh_keys
  # userdata = local.instance_userdata
  spot = local.instance_spot
}

locals {
  instance_id = module.cherryservers_server.id
  instance_ip = module.cherryservers_server.ip
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
