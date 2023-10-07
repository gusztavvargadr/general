terraform {
  required_version = "~> 1.5"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }

  cloud {
    workspaces {
      tags = ["general-aws-ec2-instance"]
    }
  }
}

provider "aws" {
  region = local.region_name

  default_tags {
    tags = {
      DeploymentName = local.deployment_name
    }
  }
}
