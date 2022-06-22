resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-demo"
  location = "northcentralus"
}