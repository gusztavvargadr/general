terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 2.1.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.2.0"
    }
  }

  cloud {
    workspaces {
      tags = ["general-aws-ec2-instance"]
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      StackName       = var.stack_name
      ServiceName     = var.service_name
      ComponentName   = var.component_name
      EnvironmentName = var.environment_name
      DeploymentName  = local.deployment_name
    }
  }
}
