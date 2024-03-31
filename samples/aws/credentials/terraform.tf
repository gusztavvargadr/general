terraform {
  required_version = "~> 1.5"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.17"
    }
  }

  backend "consul" {
    path = "gusztavvargadr-general-aws-credentials/terraform"
  }
}

data "vault_aws_access_credentials" "core" {
  backend = "aws"
  role    = "core"
}

output "access_key" {
  value     = data.vault_aws_access_credentials.core.access_key
  sensitive = true
}

output "secret_key" {
  value     = data.vault_aws_access_credentials.core.secret_key
  sensitive = true
}

# output "security_token" {
#   value     = data.vault_aws_access_credentials.core.security_token
#   sensitive = true
# }
