terraform {
  required_version = "~> 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 2.1.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "~> 3.1.0"
    }

    local = {
      source = "hashicorp/local"
      version = "~> 2.2.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Stack = var.stack
      Service = var.service
      Component = var.component
      Environment = var.environment
    }
  }
}
