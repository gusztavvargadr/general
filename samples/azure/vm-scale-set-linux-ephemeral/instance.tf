locals {
  instance_name = local.deployment_name

  instance_size         = "Standard_D8lds_v5"
  instance_user         = "ubuntu"
  instance_disk_type    = "Standard_LRS"
  instance_disk_size    = 255
  instance_disk_caching = "ReadOnly"
}

resource "azurerm_network_interface" "instance" {
  resource_group_name = local.resource_group_name

  name     = local.instance_name
  location = local.location_name

  ip_configuration {
    name                          = local.network_name
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

locals {
  network_interface_id = azurerm_network_interface.instance.id
}

resource "azurerm_linux_virtual_machine_scale_set" "instance" {
  resource_group_name = local.resource_group_name

  name     = local.instance_name
  location = local.location_name

  source_image_id = "/subscriptions/c81f8944-4346-498b-9080-4e3ef050b052/resourceGroups/vsts-agents/providers/Microsoft.Compute/images/ubuntu-virtualbox-240920"

  sku             = local.instance_size
  priority        = "Spot"
  eviction_policy = "Delete"

  os_disk {
    storage_account_type = local.instance_disk_type
    disk_size_gb         = local.instance_disk_size
    caching              = local.instance_disk_caching

    diff_disk_settings {
      option    = "Local"
      placement = "ResourceDisk"
    }
  }

  network_interface {
    name    = local.instance_name
    primary = true

    ip_configuration {
      name      = local.network_name
      subnet_id = local.subnet_id
      primary   = true
    }
  }

  admin_username = local.instance_user

  admin_ssh_key {
    username   = local.instance_user
    public_key = local.ssh_key_public
  }

  instances     = 0
  overprovision = false
}

locals {
  instance_id = azurerm_linux_virtual_machine_scale_set.instance.id
}

output "instance_id" {
  value = local.instance_id
}

output "instance_name" {
  value = local.instance_name
}
