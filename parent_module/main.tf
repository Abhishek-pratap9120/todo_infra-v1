module "dev-todo-rg" {
    source = "../child_module/resource_group"
    dev-todo-rg-name = var.dev-todo-rgname
    dev-todo-rg-location = var.dev-todolocation
  
}
module "dev-todo-vnet" {
    source = "../child_module/virtual_network"
    depends_on = [ module.dev-todo-rg ]
    dev-todo-vnet-name=var.dev-todo-vnetname
    dev-todo-location=var.dev-todolocation
    dev-todo-rg-name=var.dev-todo-rgname
    dev-todo-vnet-address_space=var.dev-todo-vnetaddress_space
}
module "dev-todo-frontend-subnet" {
    source = "../child_module/subnet"
    depends_on = [ module.dev-todo-vnet,module.dev-todo-rg ]
    dev-todo-subnet-name=var.dev-todo-frontend-subnet-name
    dev-todo-rg-name=var.dev-todo-rgname
    dev-todo-vnet-name = var.dev-todo-vnetname
    dev-todo-subnet-address_prefixes=var.dev-todo-fsubnet-address_prefixes 
}
# # module "dev-todo-backend-subnet" {
# #     source = "../child_module/subnet"
# #     depends_on = [ module.dev-todo-vnet,module.dev-todo-rg ]
# #     dev-todo-subnet-name=var.dev-todo-backend-subnet-name
# #     dev-todo-rg-name=var.dev-todo-rgname
# #     dev-todo-vnet-name = var.dev-todo-vnetname
# #     dev-todo-subnet-address_prefixes=var.dev-todo-bsubnet-address_prefixes  
# }
module "dev-todo-kv" {
    source = "../child_module/key vault"
    depends_on = [ module.dev-todo-rg ]
    dev-todo-keyvault-name=var.dev-todo-kvname
    dev-todo-location=var.dev-todolocation
    dev-todo-rg-name = var.dev-todo-rgname 
}
module "dev-todo-keysecret-username" {
    source = "../child_module/key vault secret"
    depends_on = [ module.dev-todo-kv ]
    dev-todo-keysecret-name = var.dev-todo-kvs-fusername
    dev-todo-keysecret-value = var.dev-todo-kvs-fvalue
    dev-todo-rg-name=var.dev-todo-rgname
    dev-todo-keyvault-name=var.dev-todo-kvname
    dev-todo-keysecret-content_type = var.dev-todo-keysecret_content_type_username
    dev-todo-not_before_date = "2025-12-12T00:00:00Z"
    dev-todo-expiration_date = "2025-12-23T00:00:00Z"
}
module "dev-todo-keysecret-password" {
    source = "../child_module/key vault secret"
    depends_on = [ module.dev-todo-kv ]
    dev-todo-keysecret-name = var.dev-todo-kvs-fpassword
    dev-todo-keysecret-value = var.dev-todo-kvs-fpassword-value
    dev-todo-rg-name=var.dev-todo-rgname
    dev-todo-keyvault-name=var.dev-todo-kvname
    dev-todo-keysecret-content_type = var.dev-todo-keysecret_content_type_password
    dev-todo-not_before_date = "2025-12-12T00:00:00Z"
    dev-todo-expiration_date = "2025-12-23T00:00:00Z"
}
module "dev-todo-frontend-VM" {
    source = "../child_module/VM"
    depends_on = [ module.dev-todo-rg,module.dev-todo-vnet,module.dev-todo-frontend-subnet,module.dev-todo-kv,module.dev-todo-keysecret-username,module.dev-todo-keysecret-password ]
    dev-todo-nic-name=var.dev-todo-nic_name
    dev-todo-rg-name=var.dev-todo-rgname
    dev-todo-location=var.dev-todolocation
    dev-todo-ipconfig-name = var.dev-todo-ipconfig_name
    dev-todo-private_ip_address_allocation=var.dev-todo-privateip_address_allocation
    dev-todo-vm-name=var.dev-todo-fvm-name
    dev-todo-subnet-name = var.dev-todo-frontend-subnet-name
    dev-todo-vnet-name=var.dev-todo-vnetname
    dev-todo-keyvault-name=var.dev-todo-kvname
    dev-todo-keysecret-username = var.dev-todo-kvs-fusername
    dev-todo-keysecret-password-name = var.dev-todo-kvs-fpassword
}