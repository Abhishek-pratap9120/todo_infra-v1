# checkov:skip=CKV2_AZURE_31: NSG not linked for demo purpose
resource "azurerm_subnet" "dev-todo-subnet" {
  name                 = var.dev-todo-subnet-name
  resource_group_name  = var.dev-todo-rg-name
  virtual_network_name = var.dev-todo-vnet-name
  address_prefixes     = var.dev-todo-subnet-address_prefixes                                                
}  



















#   delegation {
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#     }
#   }
