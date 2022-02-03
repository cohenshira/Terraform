variable "location" {
    type = string
    default = "westeurope"
}

variable "resource_group" {
    type = string
    default = "shira-rg"
}

variable "vn_name" {
    type = string
    description = "Name for the virtual network"
}

variable "vnet_address_space" {
    type = list
    description = "Address Space For Virtual Network"
}

variable "sub_name" {
    type = string
    description = "Name for the subnet"
}

variable "vnet_address_prefix" {
    type = list
    description = "Adress Prefix for Subnet"
}

variable "nsg_name" {
    type = string
    description = "Name for the subnet"
}

variable "pip_name" {
    type = string
    description = "Name for Public IP"
}


variable "vmnic_name" {
    type = string
    description = "Name for the network interface resource"
}



