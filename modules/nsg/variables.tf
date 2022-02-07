variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}

variable "nsg_name" {
  type        = string
  description = "Name for the subnet"
}

variable "nsg_rules" {
  type        = map(any)
  description = "Rules of the network security group"
}

variable "subnet_ids" {
  type        = map(any)
  description = "ID of the subnet we want to connect the network security group"
}
