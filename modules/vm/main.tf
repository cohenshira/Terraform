
resource "azurerm_public_ip" "vmpublicip" {
  name                = var.p_ip_name
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = var.ip_allocation
  sku                 = var.sku
}

resource "azurerm_network_interface" "vmnic" {
  name                = var.vmnic_name
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = var.ipconf_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.ip_allocation
    public_ip_address_id          = azurerm_public_ip.vmpublicip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.hostname
  resource_group_name             = var.resource_group
  location                        = var.location
  size                            = "Standard_F2"
  computer_name                   = var.hostname
  disable_password_authentication = var.pass_auth
  admin_username                  = var.username
  admin_password                  = var.password
  network_interface_ids           = ["${azurerm_network_interface.vmnic.id}"]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
