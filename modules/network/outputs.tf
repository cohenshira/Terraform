output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_name" {
  value = [for subnet in azurerm_subnet.subnet : subnet.name]
}

output "subnet_ids" {
  value = [for subnet in azurerm_subnet.subnet : subnet.id]
}

