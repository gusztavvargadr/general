variable "ca_name" {
  type    = string
  default = "localhost"
}

variable "server_name" {
  type    = string
  default = "vault"
}

locals {
  ca_name     = var.ca_name
  server_name = var.server_name

  artifacts_path = "${path.root}/artifacts/"
}
