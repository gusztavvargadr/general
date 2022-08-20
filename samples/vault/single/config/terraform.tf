terraform {
  required_version = ">= 1.2.0"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.2.0"
    }
  }

  backend "local" {
    path = "./.terraform/backends/local/terraform.tfstate"
  }
}

provider "tls" {
}

provider "local" {
}
