locals {
  location = "westeurope"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  vnet1_name    = "shira-vnet1"
  address_space = ["10.0.0.0/16"]
  subnets1_list = {
    subnet1 = {
      subnet_name      = "shira-subnet-1"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
  nsg1_name     = "shira-nsg-1"
  nic1_name     = "shira-nic-1"
  hostname1     = "shira-vm-1"
  linux_count   = 1
  windows_count = 0
  vnet2_name    = "shira-vnet2"
  subnets2_list = {
    subnet2 = {
      subnet_name      = "shira-subnet-2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
  nsg2_name = "shira-nsg-2"
  nic2_name = "shira-nic-2"
  hostname2 = "shira-vm-2"
  vm_size   = "Standard_F2"

  nsg_rules = {

    ssh_out = {
      name                       = "ssh-out"
      priority                   = 1001
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    ssh_in = {
      name                       = "ssh-in"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    icmp = {
      name                       = "ping"
      priority                   = 1003
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}



resource "azurerm_resource_group" "rg" {
  name     = "shira-rg"
  location = var.location
}

#Creates ENV1
module "vnet1" {
  source             = "./modules/network"
  vnet_name          = local.vnet1_name
  resource_group     = azurerm_resource_group.rg.name
  vnet_address_space = local.address_space
  subnets            = local.subnets1_list
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "nsg1" {
  source         = "./modules/nsg"
  resource_group = azurerm_resource_group.rg.name
  nsg_name       = local.nsg1_name
  nsg_rules      = local.nsg_rules
  subnet_ids     = module.vnet1.subnet_ids
  depends_on = [
    azurerm_resource_group.rg, module.vnet1.vnet
  ]
}

module "virtual_machine_1" {
  source         = "./modules/vm"
  vmnic_name     = local.nic1_name
  subnet_id      = module.vnet1.subnet_ids[0]
  linux_count    = local.linux_count
  windows_count  = local.windows_count
  hostname       = local.hostname1
  username       = var.username
  password       = var.password
  vm_size        = local.vm_size
  caching        = local.os_disk.caching
  sa_type        = local.os_disk.storage_account_type
  publisher      = local.source_image_reference.publisher
  offer          = local.source_image_reference.offer
  image_sku      = local.source_image_reference.sku
  image_version  = local.source_image_reference.version
  resource_group = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_resource_group.rg, module.vnet1.vnet
  ]
}


#Creates EVN2
module "vnet2" {
  source             = "./modules/network"
  vnet_name          = local.vnet2_name
  resource_group     = azurerm_resource_group.rg.name
  vnet_address_space = local.address_space
  subnets            = local.subnets2_list
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "nsg2" {
  source         = "./modules/nsg"
  resource_group = azurerm_resource_group.rg.name
  nsg_name       = local.nsg2_name
  nsg_rules      = local.nsg_rules
  subnet_ids     = module.vnet2.subnet_ids
  depends_on = [
    azurerm_resource_group.rg, module.vnet2.vnet
  ]
}

module "virtual_machine_2" {
  source         = "./modules/vm"
  vmnic_name     = local.nic2_name
  subnet_id      = module.vnet2.subnet_ids[0]
  linux_count    = local.linux_count
  windows_count  = local.windows_count
  hostname       = local.hostname2
  username       = var.username
  password       = var.password
  caching        = local.os_disk.caching
  sa_type        = local.os_disk.storage_account_type
  publisher      = local.source_image_reference.publisher
  offer          = local.source_image_reference.offer
  image_sku      = local.source_image_reference.sku
  image_version  = local.source_image_reference.version
  vm_size        = local.vm_size
  resource_group = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_resource_group.rg, module.vnet2.vnet
  ]
}

