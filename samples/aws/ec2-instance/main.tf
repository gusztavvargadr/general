variable "stack" {
  type    = string
  default = "gusztavvargadr-general"
}

variable "service" {
  type    = string
  default = "aws-ec2-instance"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

locals {
  deployment_options = {
    stack       = var.stack
    service     = var.service
    environment = terraform.workspace
    region      = var.region
  }
}

locals {
  deployment = {
    name        = "${local.deployment_options.stack}.${local.deployment_options.service}.${local.deployment_options.environment}"
    stack       = local.deployment_options.stack
    service     = local.deployment_options.service
    environment = local.deployment_options.environment
    region      = local.deployment_options.region
  }
}

output "deployment" {
  value = local.deployment
}
