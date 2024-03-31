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
  stack_name = var.stack
  service_name = var.service
  environment_name = terraform.workspace

  deployment_name = "${local.stack_name}-${local.service_name}-${local.environment_name}"

  region_name     = var.region
}

output "deployment" {
  value = local.deployment_name
}
