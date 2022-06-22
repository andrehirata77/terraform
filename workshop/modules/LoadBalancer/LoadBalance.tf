resource "azurerm_public_ip" "lb-pip" {
  name                = "lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku = "Standard"
  domain_name_label = "workshop-ttech"
  
}

resource "azurerm_lb" "main" {
  name                = "${var.lb_name}-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku = "Standard"

  frontend_ip_configuration {
    name                 = var.fend_name
    public_ip_address_id = azurerm_public_ip.lb-pip.id
    
  }
}
resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id = azurerm_lb.main.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "adress_poolA" {
  name                    = "adress_pool_vm1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
  virtual_network_id      = var.virtual_network_id
  ip_address              = var.vms_ip_a
}

resource "azurerm_lb_backend_address_pool_address" "adress_poolB" {
  name                    = "adress_pool_vm2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
  virtual_network_id      = var.virtual_network_id
  ip_address              = var.vms_ip_b
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.fend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
}
resource "azurerm_lb_probe" "example" {
  loadbalancer_id = azurerm_lb.main.id
  name            = "app_health_check"
  port            = 80
}

####################

resource "azurerm_availability_set" "app_set" {
  name                = "app-set"
  location            = var.location                        ##azurerm_resource_group.app_grp.location
  resource_group_name = var.resource_group_name             ##azurerm_resource_group.app_grp.name
  platform_fault_domain_count = 3
  platform_update_domain_count = 3  
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = "app-nsg"
  location            = var.location                        ##azurerm_resource_group.app_grp.location
  resource_group_name = var.resource_group_name              ##azurerm_resource_group.app_grp.name

# We are creating a rule to allow traffic on port 80
  security_rule {
    name                       = "Allow_HTTP_Demo"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.subnet_id              ##azurerm_subnet.SubnetA.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
  depends_on = [
    azurerm_network_security_group.app_nsg
  ]
}