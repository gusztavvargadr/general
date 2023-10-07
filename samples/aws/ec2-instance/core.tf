variable "component_name" {
  type    = string
  default = "general-aws-ec2-instance"
}

variable "environment_name" {
  type    = string
  default = "local"
}

variable "region_name" {
  type    = string
  default = "eu-west-1"
}

locals {
  deployment_name = "${var.component_name}-${var.environment_name}"
  region_name     = var.region_name
}

output "deployment_name" {
  value = local.deployment_name
}
