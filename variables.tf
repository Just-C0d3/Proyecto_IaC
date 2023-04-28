variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "address_space" {
  type = list(string)
}
variable "azurerm_resource_group" {
  type = string
}
variable "virtual_network_name" {
  type = string
}
variable "azurerm_resource_group_name" {
    type = string
}
variable "azurerm_subnet_name" {
    type = string
}
variable "addres_prefixes" {
    type = list(string)
}
variable "azurerm_public_ip_name" {
    type = string
}
variable "azurerm_public_ip_name2" {
    type = string
}
variable "azurerm_public_ip_name3" {
    type = string
}
variable "allocation_method" {
    type = string
}
variable "azurerm_network_security_group_name" {
    type = string
}
variable "azurerm_network_interface_name" {
    type = string
}
variable "azurerm_network_interface_name2" {
    type = string
}
variable "azurerm_network_interface_name3" {
    type = string
}
variable "ip_configuration_name" {
    type = string
}
variable "ip_configuration_name2" {
    type = string
}
variable "ip_configuration_name3" {
    type = string
}
variable "azurerm_storage_account_name" {
    type = string
}
variable "account_replication_type" {
    type = string
}
variable "account_tier" {
    type = string
}
variable "azurerm_windows_virtual_machine_name" {
    type = string
}
variable "admin_username" {
    type = string
}
variable "admin_password" {
    type = string
}
variable "network_interface_id" {
    type = list(string)
}
variable "publisher" {
    type = string
}
variable "offer" {
    type = string
}
variable "sku" {
    type = string
}
variable "version2" {
    type = string
}
variable "publisher2" {
    type = string
}
variable "offer2" {
    type = string
}
variable "sku2" {
    type = string
}
variable "servers" {
  type = map(object({
    name = string
    admin_username = string
    admin_password  = string
    location  = string
    resource_group_name = string
    network_interface_ids = list(string)
    size = string
    os_disk_name = string

  }))
  default = {
    "key" = {
    name = "server1"
    admin_username = "Martin"
    admin_password  = "P@ssw0rd1"
    location  = "eastus"
    resource_group_name = "TractorAzul"
    network_interface_ids = ["/subscriptions/753812e2-49f3-4084-abf2-ab439fbb8cc0/resourceGroups/TractorAzul/providers/Microsoft.Network/networkInterfaces/avion_violeta"]
    size ="Standard_DS1_v2" 
    os_disk_name = "MyOsDisk"
    }
  }
}
