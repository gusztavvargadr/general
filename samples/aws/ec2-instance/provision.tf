locals {
  provision_options = {
    type        = "ssh"
    host        = local.instance.public_ip
    user        = local.instance.user
    private_key = module.ssh_key.ssh_key.private

    script = "${path.root}/provision.sh"
  }
}

resource "terraform_data" "provision" {
  triggers_replace = [
    local.provision_options.host,
    md5(file(local.provision_options.script))
  ]

  connection {
    type        = local.provision_options.type
    host        = local.provision_options.host
    user        = local.provision_options.user
    private_key = local.provision_options.private_key
  }

  provisioner "remote-exec" {
    script = local.provision_options.script
  }
}
