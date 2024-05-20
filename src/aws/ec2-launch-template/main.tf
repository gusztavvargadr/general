terraform {
  required_version = "~> 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }
  }
}

variable "deployment" {
  type = object({
    name = string
    tags = map(string)
  })
}

locals {
  deployment = var.deployment
}

variable "launch_template" {
  type = object({
    ami_id = string

    instance_type           = optional(string, "t3.nano")
    instance_market_options = optional(string, "spot")

    volume_type = optional(string, "gp3")
    volume_size = optional(number, 8)

    vpc_id = string

    public_key = string
    user_data  = optional(string, "")
  })
}

locals {
  launch_template_options = var.launch_template
}
