data "azurerm_key_vault" "dev-todo-keyvault-data" {
  name                = var.dev-todo-keyvault-name
  resource_group_name = var.dev-todo-rg-name
}