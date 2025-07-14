# checkov:skip=CKV_AZURE_189: Public network enabled for demo only
# checkov:skip=CKV2_AZURE_32: No private endpoint for demo
resource "azurerm_key_vault" "dev-todo-keyvault" {
  name                        = var.dev-todo-keyvault-name
  location                    = var.dev-todo-location
  resource_group_name         = var.dev-todo-rg-name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  network_acls {
    bypass = "none"
    default_action = "Deny"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get","Create"
    ]

    secret_permissions = [
      "Get","Update","Create","Delete","Recover","Purge"
    ]

    storage_permissions = [
      "Get"
    ]
  }
}