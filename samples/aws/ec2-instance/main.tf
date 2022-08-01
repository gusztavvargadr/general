variable "stack" {
  type    = string
  default = "general"
}

variable "service" {
  type    = string
  default = "aws-ec2"
}

variable "component" {
  type = string
  default = "instance"
}

variable "environment" {
  type    = string
  default = "local"
}

locals {
  default_component_name = "${var.stack}-${var.service}-${var.component}-${var.environment}"
}

output "instance_id" {
  value = local.default_instance_id
}

output "instance_public_ip" {
  value = local.default_instance_public_ip
}

output "public_key_filename" {
  value = local.public_key_filename
}

output "private_key_filename" {
  value = local.private_key_filename
}
