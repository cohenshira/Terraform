variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}

variable "vnet_name" {
  type        = string
  description = "Name for the virtual network"
}

variable "vnet_address_space" {
  type        = list(any)
  description = "Address Space For Virtual Network"
}

variable "subnets" {
  type        = map(any)
  description = "subnets list"
}



