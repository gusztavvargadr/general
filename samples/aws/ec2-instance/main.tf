variable "stack_name" {
  type    = string
  default = "general"
}

variable "service_name" {
  type    = string
  default = "aws"
}

variable "component_name" {
  type    = string
  default = "ec2-instance"
}

variable "environment_name" {
  type    = string
  default = "local"
}

locals {
  deployment_name = "${var.stack_name}-${var.service_name}-${var.component_name}-${var.environment_name}"
}

output "instance_id" {
  value = local.instance_id
}

output "instance_public_ip" {
  value = local.instance_public_ip
}

output "key_pair_public_key_filename" {
  value = local.key_pair_public_key_filename
}

output "key_pair_private_key_filename" {
  value = local.key_pair_private_key_filename
}
