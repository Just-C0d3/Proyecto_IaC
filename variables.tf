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
variable "allocation_method" {
    type = string
}
variable "azurerm_network_security_group_name" {
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
variable "caching" {
    type = string
}
variable "storage_account_type" {
    type = string
}
variable "azurerm_public_ip_name1" {
    type = string
}
variable "network_interface_id" {
    type = string
}
variable "network_interface_id2" {
    type = string
}
variable "network_interface_id3" {
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
    publisher = string
    offer = string 
    sku = string
    version = string
    name  = string
    private_ip_address_allocation = string
    azurerm_storage_account_name = string
    private_address = optional(string)
  }))

}
