variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group" {
  type    = string
  default = "shira-rg"
}

variable "subnets1_list" {
  type        = map(any)
  description = "list of subnets"
  default = {
    subnet1 = {
      subnet_name      = "shira-subnet-1"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

variable "subnets2_list" {
  type        = map(any)
  description = "list of subnets"
  default = {
    subnet2 = {
      subnet_name      = "shira-subnet-2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

variable "nsg_rules" {
  type        = map(any)
  description = "Rules for the nsg"
  default = {

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

variable "vnet1_name" {
  type    = string
  default = "shira-vnet1"
}

variable "vnet2_name" {
  type    = string
  default = "shira-vnet2"
}

variable "nsg1_name" {
  type    = string
  default = "shira-nsg-1"
}

variable "nsg2_name" {
  type    = string
  default = "shira-nsg-2"
}

variable "publicip1_name" {
  type    = string
  default = "shira-publicip-1"
}

variable "publicip2_name" {
  type    = string
  default = "shira-publicip-2"
}

variable "nic1_name" {
  type    = string
  default = "shira-nic-1"
}

variable "nic2_name" {
  type    = string
  default = "shira-nic-2"
}

variable "ipconf1_name" {
  type    = string
  default = "shira-ipconf-1"
}

variable "ipconf2_name" {
  type    = string
  default = "shira-ipconf-2"
}

variable "hostname1" {
  type    = string
  default = "shira-vm-1"
}

variable "hostname2" {
  type    = string
  default = "shira-vm-2"
}

variable "address_space" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}


