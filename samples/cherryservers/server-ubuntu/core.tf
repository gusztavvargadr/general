variable "tenant" {
  type    = string
  default = "general-cherryservers-server-ubuntu"
}

variable "environment" {
  type    = string
  default = "local"
}

variable "region" {
  type    = string
  default = "eu_nord_1"
}

locals {
  deployment = "${var.tenant}-${var.environment}"
  region     = var.region
}

output "deployment" {
  value = local.deployment
}
