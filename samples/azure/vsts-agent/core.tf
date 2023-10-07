variable "component_name" {
  type    = string
  default = "general-azure-vsts-agent"
}

variable "environment_name" {
  type    = string
  default = "local"
}

variable "region_name" {
  type    = string
  default = "eu_nord_1"
}

locals {
  deployment_name = "${var.component_name}-${var.environment_name}"
  region_name     = var.region_name
}

output "deployment_name" {
  value = local.deployment_name
}
