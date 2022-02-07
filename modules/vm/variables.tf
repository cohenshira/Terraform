variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group" {
  type = string
}

variable "p_ip_name" {
  type        = string
  description = "Name for Public IP"
}

variable "vmnic_name" {
  type        = string
  description = "Name for the network interface resource"
}

variable "sku" {
  type    = string
  default = "Basic"
}

variable "ip_allocation" {
  type        = string
  description = "IP Allocation - Static or Dynamic"
  default     = "Static"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet used in the network interface creation"
}

variable "ipconf_name" {
  type        = string
  description = "Name of for the IP configuration"
}

variable "hostname" {
  type        = string
  description = "Name For The Virtual Machine"
}

variable "pass_auth" {
  type        = bool
  description = "Disabling Password authentication - true or false"
  default     = false
}

variable "username" {
  type        = string
  description = "Username"
  default     = "adminroot"
}

variable "password" {
  type        = string
  description = "user password"
}

