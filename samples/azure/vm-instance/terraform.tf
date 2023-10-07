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

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }

  cloud {
    workspaces {
      tags = ["general-azure-vm-instance"]
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
}
