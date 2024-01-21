locals {
  instance_name = local.deployment_name

  instance_size         = "Standard_B1s"
  instance_user         = "ubuntu"
  instance_disk_type    = "Premium_LRS"
  instance_disk_size    = 127
  instance_disk_caching = "ReadWrite"

  instance_image_publisher = "Canonical"
  instance_image_offer     = "0001-com-ubuntu-server-focal"
  instance_image_sku       = "20_04-lts-gen2"
  instance_image_version   = "latest"
}

resource "azurerm_public_ip" "instance" {
  resource_group_name = local.resource_group_name

  name              = local.instance_name
  location          = local.location_name
  allocation_method = "Static"
  sku               = "Standard"
}

locals {
  public_ip_id = azurerm_public_ip.instance.id
}

resource "azurerm_network_interface" "instance" {
  resource_group_name = local.resource_group_name

  name     = local.instance_name
  location = local.location_name

  ip_configuration {
    name                          = local.network_name
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = local.public_ip_id
  }
}

locals {
  network_interface_id = azurerm_network_interface.instance.id
}

resource "azurerm_network_interface_security_group_association" "instance" {
  network_interface_id      = local.network_interface_id
  network_security_group_id = local.security_group_id
}

resource "azurerm_linux_virtual_machine" "instance" {
  resource_group_name = local.resource_group_name

  name     = local.instance_name
  location = local.location_name

  source_image_reference {
    publisher = local.instance_image_publisher
    offer     = local.instance_image_offer
    sku       = local.instance_image_sku
    version   = local.instance_image_version
  }

  size = local.instance_size

  os_disk {
    storage_account_type = local.instance_disk_type
    disk_size_gb         = local.instance_disk_size
    caching              = local.instance_disk_caching
  }

  network_interface_ids = [
    local.network_interface_id
  ]

  admin_username = local.instance_user
  # custom_data    = base64encode(file(local.core_instance_boot_filename))

  admin_ssh_key {
    username   = local.instance_user
    public_key = local.ssh_key_public
  }
}

locals {
  instance_id = azurerm_linux_virtual_machine.instance.id
  instance_ip = azurerm_linux_virtual_machine.instance.public_ip_address
}

output "instance_id" {
  value = local.instance_id
}

output "instance_name" {
  value = local.instance_name
}

output "instance_ip" {
  value = local.instance_ip
}
