resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "${azurerm_virtual_network.main.name}-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}