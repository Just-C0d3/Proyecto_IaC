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
  for_each = var.servers
  name                = each.value.name
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
  depends_on = [ azurerm_resource_group.TractorAzul ]

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
  security_rule {
    name                       = "ssh"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface" "aviones" {
  for_each = var.servers
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.azurerm_public_ip_name
    subnet_id                     = azurerm_subnet.SubSubmarinoAmarillo.id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address = each.value.private_ip_address_allocation == "Dynamic" ? null : each.value.private_address
    public_ip_address_id          =  azurerm_public_ip.ip11[each.key].id
  }
}
resource "azurerm_network_interface_security_group_association" "asociacion" {
  for_each = var.servers
  network_interface_id      = azurerm_network_interface.aviones[each.key].id
  network_security_group_id = azurerm_network_security_group.Coche_Policia.id
  depends_on = [ azurerm_network_interface.aviones ]
}
resource "azurerm_storage_account" "camioncisterna" {
  name                     = var.azurerm_storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  depends_on = [ azurerm_resource_group.TractorAzul ]
}
resource "azurerm_virtual_machine" "servers" {
  for_each = var.servers
  name                  = each.key
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = each.value.network_interface_ids
  vm_size                  = each.value.size
  depends_on = [ azurerm_resource_group.TractorAzul ]
  
  storage_os_disk {
    name                 = each.value.os_disk_name
    caching              = each.value.caching
    create_option        = "FromImage"
    managed_disk_type    = each.value.storage_account_type
    os_type              = each.value.os_type
  }

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
  os_profile {
    computer_name  = each.key
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
    dynamic "os_profile_linux_config" {
      for_each = each.value.disable_password_authentication == null ? [] : [each.value.disable_password_authentication]
    content {
    disable_password_authentication = each.value.disable_password_authentication
    }
    }
    dynamic "os_profile_windows_config"{
     for_each = each.value.provision_vm_agent == null ? [] : [each.value.provision_vm_agent]
    content{
    provision_vm_agent  = true 
    }
    } 
}
