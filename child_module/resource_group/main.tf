resource "azurerm_resource_group" "rg_todo" {
    name=var.dev-todo-rg-name
    location = var.dev-todo-rg-location
  
}
