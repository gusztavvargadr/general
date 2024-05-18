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

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "consul" {
    path = "gusztavvargadr-general.aws-ec2-instance/terraform/state"
    gzip = true
  }
}

provider "aws" {
  region = local.deployment.region

  default_tags {
    tags = {
      Stack       = local.deployment.stack
      Service     = local.deployment.service
      Environment = local.deployment.environment
    }
  }
}
