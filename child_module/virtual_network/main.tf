resource "azurerm_virtual_network" "dev-todo-vnet" {
  name                = var.dev-todo-vnet-name
  location            = var.dev-todo-location
  resource_group_name = var.dev-todo-rg-name
  address_space       = var.dev-todo-vnet-address_space                        #["10.0.0.0/16"]
}

