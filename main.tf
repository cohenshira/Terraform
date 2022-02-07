
resource "azurerm_resource_group" "rg" {
  name     = "shira-rg"
  location = var.location
}

#Creates ENV1
module "vnet1" {
  source             = "./modules/network"
  vnet_name          = var.resource_group
  resource_group     = var.resource_group
  vnet_address_space = var.address_space
  subnets            = var.subnets1_list

}

module "nsg1" {
  source         = "./modules/nsg"
  resource_group = var.resource_group
  nsg_name       = var.nsg1_name
  nsg_rules      = var.nsg_rules
  subnet_id      = module.vnet1.subnet_id
}

module "virtual_machine_1" {
  source         = "./modules/vm"
  p_ip_name      = var.publicip1_name
  vmnic_name     = var.nic1_name
  subnet_id      = module.vnet1.subnet_ids[0]
  ipconf_name    = var.ipconf1_name
  hostname       = var.hostname1
  resource_group = var.resource_group
}


#Creates EVN2
module "vnet2" {
  source             = "./modules/network"
  vnet_name          = var.vnet2_name
  resource_group     = var.resource_group
  vnet_address_space = var.address_space
  subnets            = var.subnets2_list
}

module "nsg2" {
  source         = "./modules/nsg"
  resource_group = var.resource_group
  nsg_name       = var.nsg2_name
  nsg_rules      = var.nsg_rules
  subnet_ids     = module.vnet2.subnet_id
}

module "virtual_machine_2" {
  source         = "./modules/vm"
  p_ip_name      = var.publicip2_name
  vmnic_name     = var.nic2_name
  subnet_id      = module.vnet2.subnet_ids[0]
  ipconf_name    = var.ipconf2_name
  hostname       = var.hostname2
  resource_group = var.resource_group
}

