resource "azurerm_key_vault_secret" "dev-todo-keysecret" {
  name         = var.dev-todo-keysecret-name  #kis naam se secret bnega
  value        = var.dev-todo-keysecret-value       #user name or password k liye 
  key_vault_id = data.azurerm_key_vault.dev-todo-keyvault-data.id
  content_type = var.dev-todo-keysecret-content_type
  not_before_date = var.dev-todo-not_before_date
  expiration_date = var.dev-todo-expiration_date
}

