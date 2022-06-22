
output "RgName" {
  value = module.ResourceGroup.rg_name_out
}

output "Network_Name" {
  value = module.VirtualNetwork.vm_network_out
}
output "Load_Balance_IP" {
  value = module.LoadBalancer.lb-pip
}

output "lb-app-fqdn" {
  value = module.LoadBalancer.lb-app-fqdn
}