terraform {

 backend "azurerm" {
 }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "TractorAzul" {
  name = var.azurerm_resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "SubmarinoAmarillo" {
    name                = var.name
    location            = var.location
    resource_group_name = var.resource_group_name
    address_space       = var.address_space
    depends_on = [
      azurerm_resource_group.TractorAzul
    ]
}
resource "azurerm_subnet" "SubSubmarinoAmarillo" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.addres_prefixes
  depends_on = [
    azurerm_virtual_network.SubmarinoAmarillo
  ]
}
resource "azurerm_public_ip" "ip11" {
  name                = var.azurerm_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  depends_on = [
    azurerm_subnet.SubSubmarinoAmarillo
  ]
}
resource "azurerm_public_ip" "ip221" {
  name                = var.azurerm_public_ip_name2
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  depends_on = [
    azurerm_subnet.SubSubmarinoAmarillo
  ]
}
resource "azurerm_public_ip" "ip222" {
  name                = var.azurerm_public_ip_name3
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  depends_on = [
    azurerm_subnet.SubSubmarinoAmarillo
  ]
}
resource "azurerm_network_security_group" "Coche_Policia" {
  name                = var.azurerm_network_security_group_name
  location            = var.location
  resource_group_name = var.azurerm_resource_group_name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface" "avion_violeta" {
  name                = var.azurerm_network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.SubSubmarinoAmarillo.id
    private_ip_address_allocation = var.allocation_method
    public_ip_address_id          = azurerm_public_ip.ip11.id
  }
}
resource "azurerm_network_interface" "avion_verde" {
  name                = var.azurerm_network_interface_name2
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name2
    subnet_id                     = azurerm_subnet.SubSubmarinoAmarillo.id
    private_ip_address_allocation = var.allocation_method
    public_ip_address_id          = azurerm_public_ip.ip221.id
  }
}
resource "azurerm_network_interface" "avion_nieve" {
  name                = var.azurerm_network_interface_name3
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name3
    subnet_id                     = azurerm_subnet.SubSubmarinoAmarillo.id
    private_ip_address_allocation = var.allocation_method
    public_ip_address_id          = azurerm_public_ip.ip222.id
  }
}
resource "azurerm_network_interface_security_group_association" "asociacion" {
  network_interface_id      = azurerm_network_interface.avion_violeta.id
  network_security_group_id = azurerm_network_security_group.Coche_Policia.id
}
resource "azurerm_storage_account" "camioncisterna" {
  name                     = var.azurerm_storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}
resource "azurerm_windows_virtual_machine" "w11" {
  name                  = var.azurerm_windows_virtual_machine_name
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  location              = var.location
  resource_group_name   = var.azurerm_resource_group_name
  network_interface_ids = var.network_interface_id
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version2
  }
}
resource "azurerm_windows_virtual_machine" "servers" {
  for_each = var.servers
  name                  = each.key
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = each.value.network_interface_ids
  size                  = each.value.size

  os_disk {
    name                 = each.value.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.publisher2
    offer     = var.offer2
    sku       = var.sku2
    version   = var.version2
  }
}
