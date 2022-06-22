resource "azurerm_virtual_network" "main" {
  name                = "${var.network_name}-network"
  address_space       = var.addres_space
  location            = var.location
  resource_group_name = var.rg_name
}


resource "azurerm_subnet" "internal" {
  name                 = "${var.network_name}-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = "${var.network_name}-network"
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [
    azurerm_virtual_network.main
  ]
}


#resource "azurerm_network_interface" "main" {
#  name                = "${var.network_name}-nic"
#  location            = var.location
#  resource_group_name = var.rg_name
#
#  ip_configuration {
#    name                          = "${var.network_name}-ip"
#    subnet_id                     =  azurerm_subnet.internal.id
#    private_ip_address_allocation = "Dynamic"
#  }
#}
