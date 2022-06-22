output "vm_network_out" {
  value = resource.azurerm_virtual_network.main.name
}

output "subnet_ID" {
  value = azurerm_subnet.internal.id
  
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
  
}