terraform {
  required_version = "~> 1.5"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.15"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  cloud {
    workspaces {
      tags = ["general-letsencrypt-account"]
    }
  }
}
