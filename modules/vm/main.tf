#Creates Linux VM

resource "azurerm_linux_virtual_machine" "vm" {
    name                = var.hostname
    resource_group_name = var.resource_group
    location            = var.location
    size                = "Standard_F2"
    computer_name       = var.hostname
    disable_password_authentication  = false
    admin_username      = "adminroot"
    admin_password      = "Aa1234567890"
    network_interface_ids = [ "${var.vmnic_id}" ]



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
