locals {
  ssh_key_name = local.deployment_name
}

data "http" "ssh_key_public" {
  url = "https://github.com/gusztavvargadr.keys"
}

locals {
  ssh_key_public = trimspace(data.http.ssh_key_public.response_body)
}

resource "aws_key_pair" "ssh_key" {
  key_name   = local.ssh_key_name
  public_key = local.ssh_key_public

  tags = {
    Name = local.ssh_key_name
  }
}

locals {
  ssh_key_id = aws_key_pair.ssh_key.id
}

output "ssh_key_id" {
  value = local.ssh_key_id
}
