terraform {
  required_version = "~> 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }

  backend "consul" {
    path = "gusztavvargadr-general.aws-ec2-autoscaling/terraform/state"
    gzip = true
  }
}

variable "deployment" {
  type = object({
    stack       = optional(string, "gusztavvargadr-general")
    service     = optional(string, "aws-ec2-autoscaling")
    environment = optional(string)
    region      = optional(string, "eu-west-1")
  })
  default = {}
}

locals {
  deployment_options = {
    stack       = var.deployment.stack
    service     = var.deployment.service
    environment = coalesce(var.deployment.environment, terraform.workspace)
    region      = var.deployment.region
  }

  deployment_options_name = "${local.deployment_options.stack}.${local.deployment_options.service}.${local.deployment_options.environment}"
}

locals {
  deployment = {
    name        = local.deployment_options_name
    region      = local.deployment_options.region

    tags = {
      Name        = local.deployment_options_name
      Stack       = local.deployment_options.stack
      Service     = local.deployment_options.service
      Environment = local.deployment_options.environment
    }
  }
}

output "deployment" {
  value = local.deployment
}

provider "aws" {
  region = local.deployment.region

  default_tags {
    tags = local.deployment.tags
  }
}

locals {
  resource_group_options = {
    name = local.deployment.name
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    { "Key": "Stack", "Values": ["${local.deployment.tags.Stack}"] },
    { "Key": "Service", "Values": ["${local.deployment.tags.Service}"] },
    { "Key": "Environment", "Values": ["${local.deployment.tags.Environment}"] }
  ]
}
JSON
  }
}

resource "aws_resourcegroups_group" "default" {
  name = local.resource_group_options.name

  resource_query {
    query = local.resource_group_options.query
  }
}

locals {
  resource_group = {
    id   = aws_resourcegroups_group.default.id
    name = aws_resourcegroups_group.default.name
  }
}

output "resource_group" {
  value = local.resource_group
}
