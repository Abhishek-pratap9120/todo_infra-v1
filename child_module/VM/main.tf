resource "azurerm_network_interface" "dev-todo-nic" {
  name                = var.dev-todo-nic-name
  location            = var.dev-todo-location
  resource_group_name = var.dev-todo-rg-name

  ip_configuration {
    name                          = var.dev-todo-ipconfig-name  #"internal"
    subnet_id                     = data.azurerm_subnet.dev-todo-subnet-data.id
    private_ip_address_allocation = var.dev-todo-private_ip_address_allocation        #"Dynamic"
  }
}
# checkov:skip=CKV_AZURE_1: Password auth used for demo only
# checkov:skip=CKV_AZURE_149: Password auth used for demo
# checkov:skip=CKV_AZURE_178: No SSH for demo
# tfsec:ignore:azure-compute-disable-password-authentication
resource "azurerm_linux_virtual_machine" "dev-todo-vm" {
  name                = var.dev-todo-vm-name 
  resource_group_name = var.dev-todo-rg-name
  location            = var.dev-todo-location
  size                = "Standard_F2"
  disable_password_authentication = false  
  admin_username      = data.azurerm_key_vault_secret.dev-todo-keysecret-username-data.value
  admin_password      = data.azurerm_key_vault_secret.dev-todo-keysecret-password-data.value
  network_interface_ids = [
    data.azurerm_network_interface.dev-todo-nic-data.id
  ]

os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
allow_extension_operations=false
source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}