variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group" {
  type    = string
  default = "shira-rg"
}

variable "username" {
  type        = string
  description = "Username"
  default     = "azureuser"
}

variable "password" {
  type        = string
  default = "Aa1234567890"
}

