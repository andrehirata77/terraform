terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">2.88.1"
    }
  }
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

  }
}
data "template_file" "nginx-vm-cloud-init" {
  template = file("install-nginx.sh")
}

module "ResourceGroup" {
  source    = "./ResourceGroup"
  base_name = "rg-ttech-workshop"
  location  = "West US"
}

module "StorageAccount" {
  source              = "./StorageAccount"
  base_name           = "TerraformExample01"
  resource_group_name = module.ResourceGroup.rg_name_out
  location            = "West US"
}

module "VirtualNetwork" {
  source       = "./VirtualNetwork"
  addres_space = ["10.0.0.0/16"]
  location     = "West US"
  subnetid     = 25

  depends_on = [
    module.ResourceGroup
  ]
}

module "VirtualMachine" {
  source               = "./VirtualMachine"
  prefix               = "finops"
  location             = "West US"
  resource_group_name  = module.ResourceGroup.rg_name_out
  interface_ids        = [module.VirtualMachine.interface_id_out]
  virtual_network_name = module.VirtualNetwork.vm_network_out
  subnet_ID            = module.VirtualNetwork.subnet_ID
  availability_set_id  = module.LoadBalancer.availability_set_id
  custom_data          = base64encode(data.template_file.nginx-vm-cloud-init.rendered)
  depends_on = [
    module.ResourceGroup,
    module.VirtualNetwork
  ]
}

module "VirtualMachine2" {
  source               = "./VirtualMachine2"
  prefix               = "finops"
  location             = "West US"
  resource_group_name  = module.ResourceGroup.rg_name_out
  interface_ids        = [module.VirtualMachine2.interface_id_out]
  virtual_network_name = module.VirtualNetwork.vm_network_out
  subnet_ID            = module.VirtualNetwork.subnet_ID
  availability_set_id  = module.LoadBalancer.availability_set_id
  custom_data          = base64encode(data.template_file.nginx-vm-cloud-init.rendered)
  depends_on = [
    module.ResourceGroup,
    module.VirtualNetwork,
  ]
}

module "PublicIP" {
  source              = "./PublicIP"
  location            = "West US"
  pip_name            = "Public_Static_IP"
  resource_group_name = module.ResourceGroup.rg_name_out
  depends_on = [
    module.ResourceGroup
  ]
}

module "LoadBalancer" {
  source              = "./LoadBalancer"
  lb_name             = "Fend"
  resource_group_name = module.ResourceGroup.rg_name_out
  location            = "West US"
  fend_name           = "frontEnd"
  interface_ids       = [module.VirtualMachine.interface_id_out, module.VirtualMachine2.interface_id_out]
  prefix              = "PREFIXO_AQUI"
  subnet_id           = module.VirtualNetwork.subnet_ID
  virtual_network_id  = module.VirtualNetwork.vnet_id
  vms_ip_a            = module.VirtualMachine.vm_interface_private_ip
  vms_ip_b            = module.VirtualMachine2.vm_interface_private_ip
  depends_on = [
    module.PublicIP
  ]
}

