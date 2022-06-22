output "availability_set_id" {
  value = resource.azurerm_availability_set.app_set.id
}

output "lb-pip" {
  value = azurerm_public_ip.lb-pip.ip_address
}
output "lb-app-fqdn" {
  value = azurerm_public_ip.lb-pip.fqdn
}