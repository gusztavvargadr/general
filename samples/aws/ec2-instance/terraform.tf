terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }

  backend "consul" {
    path = "gusztavvargadr-general-aws-ec2-instance/terraform"
  }
}

provider "aws" {
  region = local.region_name

  default_tags {
    tags = {
      Stack = local.stack_name
      Serice = local.service_name
      Environment = local.environment_name
      Deployment = local.deployment_name
    }
  }
}
