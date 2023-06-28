terraform {
  required_version = "~> 1.5"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.15"
    }
  }

  cloud {
    workspaces {
      tags = ["general-letsencrypt-certificate"]
    }
  }
}
