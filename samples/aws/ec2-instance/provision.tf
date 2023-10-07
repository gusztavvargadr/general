locals {
  provision_type        = "ssh"
  provision_host        = local.instance_ip
  provision_user        = local.instance_user
  provision_private_key = local.ssh_key_private
}

resource "terraform_data" "provision" {
  triggers_replace = [
    local.provision_host
  ]

  connection {
    type        = local.provision_type
    host        = local.provision_host
    user        = local.provision_user
    private_key = local.provision_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cloud-init status --wait",
      "curl -Ls https://gist.github.com/gusztavvargadr/1f0d7dddc7f48549368eaaedf19bfe55/raw/deploy.sh | sudo bash -s",
    ]
  }
}
