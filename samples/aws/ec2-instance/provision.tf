locals {
  provision_options = {
    type        = "ssh"
    host        = local.instance.ip
    user        = local.instance.user
    private_key = local.ssh_key.private

    script = [
      "sudo cloud-init status --wait",
    ]
  }
}

resource "terraform_data" "provision" {
  triggers_replace = [
    local.provision_options.host
  ]

  connection {
    type        = local.provision_options.type
    host        = local.provision_options.host
    user        = local.provision_options.user
    private_key = local.provision_options.private_key
  }

  provisioner "remote-exec" {
    inline = local.provision_options.script
  }
}
