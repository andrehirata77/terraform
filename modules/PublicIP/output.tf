output "public_IPID_out" {
  value = azurerm_public_ip.test.*.id
}

output "public_IP_out" {
  value = azurerm_public_ip.test.*.ip_address
}

output "public_ip_address" {
  value = "${azurerm_public_ip.test.*.ip_address}"
}