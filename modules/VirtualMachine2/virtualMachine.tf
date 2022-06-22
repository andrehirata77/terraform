resource "azurerm_public_ip" "vm2-pip" {
  name                = "vm2-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "vm-ccoe2"
}
resource "azurerm_network_interface" "main" {
  name                = "${var.virtual_network_name}-nic2"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.virtual_network_name}-ip2"
    subnet_id                     =  var.subnet_ID
    private_ip_address_allocation = var.public_ip_allocation_method
    public_ip_address_id          = azurerm_public_ip.vm2-pip.id
  }
}
###################################
resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm2"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.interface_ids
  vm_size               = "Standard_DS1_v2"
  availability_set_id = var.availability_set_id
  
  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vm02"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data = var.custom_data
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  /*
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nginx && sudo systemctl start nginx",
      "echo '<h1><center>Virtual Machine generated with Terraform - Git - Atlantis</center></h1>' > index.html",
      "echo '<h1><center>VM02</center></h1>' >> index.html",
      "sudo mv index.html /var/www/html/"
    ]
    on_failure = continue
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.vm2-pip.ip_address
      user        = "testadmin"
      password    = "Password1234!"
    }
}*/
}