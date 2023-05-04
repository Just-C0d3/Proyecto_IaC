name = "SubmarinoAmarillo"
resource_group_name = "TractorAzul"
location = "eastus"
address_space = ["10.0.0.0/16"]
azurerm_resource_group = "rgterra420"
virtual_network_name = "SubmarinoAmarillo"
azurerm_resource_group_name = "TractorAzul"
azurerm_subnet_name = "SubSubmarinoAmarillo"
addres_prefixes = ["10.0.1.0/24"]
azurerm_public_ip_name = "Ipw11"
azurerm_public_ip_name1 = "IpSv1"
azurerm_public_ip_name2 = "IpSv2"
azurerm_network_security_group_name = "Coche_Policia"
azurerm_storage_account_name = "camioncisterna"
account_tier = "Standard"
account_replication_type = "LRS"
caching = "ReadWrite"
storage_account_type = "Premium_LRS"
network_interface_id = "/subscriptions/753812e2-49f3-4084-abf2-ab439fbb8cc0/resourceGroups/TractorAzul/providers/Microsoft.Network/networkInterfaces/avion_violeta"
network_interface_id2 = "/subscriptions/753812e2-49f3-4084-abf2-ab439fbb8cc0/resourceGroups/TractorAzul/providers/Microsoft.Network/networkInterfaces/avion_verde"
network_interface_id3 = "/subscriptions/753812e2-49f3-4084-abf2-ab439fbb8cc0/resourceGroups/TractorAzul/providers/Microsoft.Network/networkInterfaces/avion_nieve"
allocation_method = "Dynamic"
servers = {
  Server1 = {
    admin_username = "Martin"
    admin_password  = "P@ssw0rd1"
    location  = "eastus"
    resource_group_name = "TractorAzul"
    network_interface_ids = ["/subscriptions/753812e2-49f3-4084-abf2-ab439fbb8cc0/resourceGroups/TractorAzul/providers/Microsoft.Network/networkInterfaces/avion_verde"]
    size ="Standard_DS1_v2" 
    os_disk_name = "MyOsDisk1"
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer" 
    sku = "2022-datacenter-azure-edition"
    version = "latest"
    name  = "avion_morado"         
    private_ip_address_allocation = "Dynamic"
    azurerm_storage_account_name = "avion_violeta"

  },
  Server2 = {
    admin_username = "MartinII"
    admin_password  = "P@ssw0rd1"
    location  = "eastus"
    resource_group_name = "TractorAzul"
    network_interface_ids = ["/subscriptions/753812e2-49f3-4084-abf2-ab439fbb8cc0/resourceGroups/TractorAzul/providers/Microsoft.Network/networkInterfaces/avion_nieve"]  
    size = "Standard_DS1_v2"
    os_disk_name = "MyOsDisk3"
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer" 
    sku = "2022-datacenter-azure-edition"
    version = "latest"
    name  = "avion_marron"         
    private_ip_address_allocation = "Dynamic"
    azurerm_storage_account_name = "avion_verde"
    
  },
    Cliente = {
    admin_username = "MartinII"
    admin_password  = "P@ssw0rd1"
    location  = "eastus"
    resource_group_name = "TractorAzul"
    network_interface_ids = ["/subscriptions/753812e2-49f3-4084-abf2-ab439fbb8cc0/resourceGroups/TractorAzul/providers/Microsoft.Network/networkInterfaces/avion_violeta"]  
    size = "Standard_DS1_v2"
    os_disk_name = "MyOsDisk4"
    publisher = "MicrosoftWindowsDesktop"
    offer = "Windows-11" 
    sku = "win11-21h2-pro"
    version = "latest"
    name  = "avion_granizo"         
    private_ip_address_allocation = "Static"
    azurerm_storage_account_name = "avion_nieve"
    private_address = "10.0.1.4"
    }
}

