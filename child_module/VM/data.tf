data "azurerm_network_interface" "dev-todo-nic-data" {
  name                = var.dev-todo-nic-name
  resource_group_name = var.dev-todo-rg-name
}
data "azurerm_subnet" "dev-todo-subnet-data" {
  name                 = var.dev-todo-subnet-name
  virtual_network_name = var.dev-todo-vnet-name
  resource_group_name  = var.dev-todo-rg-name
}
data "azurerm_key_vault" "dev-todo-keyvault-data" {
  name                = var.dev-todo-keyvault-name
  resource_group_name = var.dev-todo-rg-name
}
data "azurerm_key_vault_secret" "dev-todo-keysecret-username-data" {
  name         = var.dev-todo-keysecret-username
  key_vault_id = data.azurerm_key_vault.dev-todo-keyvault-data.id
}
data "azurerm_key_vault_secret" "dev-todo-keysecret-password-data" {
  name         = var.dev-todo-keysecret-password-name
  key_vault_id = data.azurerm_key_vault.dev-todo-keyvault-data.id
}