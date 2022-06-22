output "azurerm_virtual_machine_name_out" {
  value = resource.azurerm_virtual_machine.main.name
}
output "interface_id_out" {
  value = resource.azurerm_network_interface.main.id
}

output "external_pip" {
  value = resource.azurerm_network_interface.main.ip_configuration[0]
}

output "vm_interface_private_ip" {
  value = resource.azurerm_network_interface.main.private_ip_address
}