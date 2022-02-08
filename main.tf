locals {
  vm_policy_rule      = templatefile("vm_policy_rule.json",{rglocation = azurerm_resource_group.rg.location})
  subnets_policy_rule = file("subnets_policy_rule.json")
}


resource "azurerm_resource_group" "rg" {
  name     = "shira-rg-policy"
  location = var.location
}

resource "azurerm_policy_definition" "def1" {
  name         = "shira-vm-location-def"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "shira-vm-location-def"

  policy_rule = local.vm_policy_rule

}

resource "azurerm_policy_assignment" "assign1" {
  name                 = "shira-vm-assign"
  scope                = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourceGroups/shira-rg-policy"
  policy_definition_id = azurerm_policy_definition.def1.id
}


resource "azurerm_policy_definition" "def2" {
  name         = "shira-subnets-def"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "shira-subnets-def"

  policy_rule = local.subnets_policy_rule

}

resource "azurerm_policy_assignment" "assign2" {
  name                 = "shira-subnets-assign"
  scope                = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourceGroups/shira-rg-policy"
  policy_definition_id = azurerm_policy_definition.def2.id
}




resource "azurerm_policy_assignment" "assign3" {
  name                 = "shira-builtin-vm-sku-assign"
  scope                = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourceGroups/shira-rg-policy"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3"

  parameters = <<PARAMETERS
    {
    "listOfAllowedSKUs": {
        "value": [ "Standard_F2", "Standard_F4"]
    }
    }
    PARAMETERS

}





resource "azurerm_virtual_network" "vnet" {
  name                = "shira-policy-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}


