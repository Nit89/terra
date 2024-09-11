resource "azurerm_resource_group" "example" {
  name     = "example2"
  location = "Central India"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_D4s_v3"
  admin_username        = "adminuser"
  admin_password        = "Password1234!"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]



#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
    
  }

 # Custom data script to install NGINX

 custom_data = base64encode(<<EOF
    <powershell>
      $ErrorActionPreference = "Stop"
      Invoke-WebRequest -Uri https://nginx.org/download/nginx-1.21.6.zip -OutFile C:\\nginx.zip
      Expand-Archive -Path C:\\nginx.zip -DestinationPath C:\\nginx
      Remove-Item -Path C:\\nginx.zip
      Start-Process -FilePath "C:\\nginx\\nginx-1.21.6\\nginx.exe" -ArgumentList "/install" -Wait
      Write-Host "Nginx installed successfully"
    </powershell>
  EOF
  )

}

# -----------for 2nd -------------------------------

# resource "azurerm_network_security_group" "example" {
#   name                = "example-nsg"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }
# resource "azurerm_network_interface_security_group_association" "example" {
#   network_interface_id      = azurerm_network_interface.example.id
#   network_security_group_id = azurerm_network_security_group.example.id
# }

# resource "azurerm_network_security_rule" "allow_http_https" {
#   name                        = "allow-http-https"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_ranges     = ["80", "443"]
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.example.name
#   network_security_group_name = azurerm_network_security_group.example.name
# }

# -----------for 2nd -------------------------------






# creating in already created vpc and resource group 


# Reference existing Resource Group
# data "azurerm_resource_group" "existing" {
#   name = "existing-resource-group-name"
# }

# # Reference existing Virtual Network
# data "azurerm_virtual_network" "existing" {
#   name                = "existing-vnet-name"
#   resource_group_name = data.azurerm_resource_group.existing.name
# }

# # Reference existing Subnet
# data "azurerm_subnet" "existing" {
#   name                 = "existing-subnet-name"
#   virtual_network_name = data.azurerm_virtual_network.existing.name
#   resource_group_name  = data.azurerm_resource_group.existing.name
# }

# # Create Network Interface in the existing VPC
# resource "azurerm_network_interface" "example" {
#   name                = "example-nic"
#   location            = data.azurerm_resource_group.existing.location
#   resource_group_name = data.azurerm_resource_group.existing.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = data.azurerm_subnet.existing.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# # Create Windows VM in the existing Resource Group and VPC
# resource "azurerm_windows_virtual_machine" "example" {
#   name                = "example-machine"
#   resource_group_name = data.azurerm_resource_group.existing.name
#   location            = data.azurerm_resource_group.existing.location
#   size                = "Standard_D4s_v3"
#   admin_username      = "adminuser"
#   admin_password      = "Password1234!"
  
#   network_interface_ids = [
#     azurerm_network_interface.example.id,
#   ]

#   # Other VM configurations
# }
