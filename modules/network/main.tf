#Creates Virtual Network
resource "azurerm_virtual_network" "vn" {
  name                = var.vn_name
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = var.vnet_address_space
}

#Creates Subnet
resource "azurerm_subnet" "subnet" {
    name = var.sub_name
    resource_group_name = var.resource_group
    virtual_network_name = var.vn_name
    address_prefixes = var.vnet_address_prefix

}

#Creates Network Security Group
resource "azurerm_network_security_group" "nsg" {
    name = var.nsg_name
    location = var.location
    resource_group_name = var.resource_group
}


#Creates two network security rules
resource "azurerm_network_security_rule" "netrules" {
  for_each = local.nsgrules
  name = each.key
  direction = each.value.direction
  access = each.value.access
  priority = each.value.priority
  protocol = each.value.protocol
  source_port_range = each.value.source_port_range
  destination_port_range = each.value.destination_port_range
  source_address_prefix = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix  
  resource_group_name = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg.name
}

#Creates Public IP
resource "azurerm_public_ip" "vmpublicip" { 
  name = var.pip_name 
  location = var.location
  resource_group_name = var.resource_group
  allocation_method = "Dynamic" 
  sku = "Basic" 
} 


#Creates Network Interface
resource "azurerm_network_interface" "vmnic" { 
  name = var.vmnic_name 
  location = var.location
  resource_group_name = var.resource_group

  ip_configuration { 
    name = "ipconf" 
    subnet_id = azurerm_subnet.subnet.id 
    private_ip_address_allocation = "Dynamic" 
    public_ip_address_id = azurerm_public_ip.vmpublicip.id
   } 
 }

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "connect" {
    network_interface_id      = azurerm_network_interface.vmnic.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

