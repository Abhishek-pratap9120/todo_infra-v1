resource "azurerm_public_ip" "dev-todo-pip" {
  name                = var.dev-todo-pip-name
  resource_group_name = var.dev-todo-rg-name
  location            = var.dev-todo-pip-location
  allocation_method   = var.dev-todo-allocation_method                                                      #"Static"
}


