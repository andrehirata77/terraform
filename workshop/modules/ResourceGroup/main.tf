resource "azurerm_resource_group" "my-rg" {
  name = var.base_name
  location = var.location
}
