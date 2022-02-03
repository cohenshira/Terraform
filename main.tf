
#Creates resource group
resource "azurerm_resource_group" "rg" {
    name     = "shira-rg"
    location = var.location
}

#Creates ENV1

module "network1" {
  source = "./modules/network"

  vn_name = "shira-vnet1"
  vnet_address_space = ["10.0.0.0/16"]
  sub_name = "shira-subnet-1"
  vnet_address_prefix = ["10.0.1.0/24"]
  nsg_name = "shira-nsg-1"
  pip_name = "shira-publicip-1"
  vmnic_name = "shira-nic-1"

}

module "virtual_machine_1" {
  source = "./modules/vm"

  hostname = "shira-vm-1"
  vmnic_id = module.network1.vmnic_id
}



#Creates EVN2

module "network2" {
  source = "./modules/network"

  vn_name = "shira-vnet2"
  vnet_address_space = ["20.0.0.0/16"]
  sub_name = "shira-subnet-2"
  vnet_address_prefix = ["20.0.1.0/24"]
  nsg_name = "shira-nsg-2"
  pip_name = "shira-publicip-2"
  vmnic_name = "shira-nic-2"

}

module "virtual_machine_2" {
  source = "./modules/vm"

  hostname = "shira-vm-2"
  vmnic_id = module.network2.vmnic_id
}

