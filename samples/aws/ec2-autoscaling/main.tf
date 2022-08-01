variable "stack" {
  type    = string
  default = "general"
}

variable "service" {
  type    = string
  default = "aws"
}

variable "component" {
  type = string
  default = "ec2-autoscaling"
}

variable "environment" {
  type    = string
  default = "local"
}

locals {
  default_component_name = "${var.stack}-${var.service}-${var.component}-${var.environment}"
}

output "autoscaling_group_id" {
  value = local.default_autoscaling_group_id
}

output "public_key_filename" {
  value = local.public_key_filename
}

output "private_key_filename" {
  value = local.private_key_filename
}
