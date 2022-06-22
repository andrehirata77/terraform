/*
resource "azurerm_public_ip" "main" {
  name                = "${var.pip_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  ip_version = "IPv4"
}
*/
variable "counts" {
    default = "1"
}
resource "azurerm_public_ip" "test" {
  count                        = "${var.counts}"
  name                         = "test-${count.index}-pip"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  allocation_method            = "Static"
  idle_timeout_in_minutes      = 30

}

