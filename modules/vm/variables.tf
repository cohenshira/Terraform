variable "location" {
    type = string
    default = "westeurope"
}

variable "resource_group" {
    type = string
    default = "shira-rg"
}

variable "hostname" {
    type = string
    description = "Name For The Virtual Machine"
}

variable "vmnic_id" {
    type = string
    description = "VM Network Interface ID"
}
