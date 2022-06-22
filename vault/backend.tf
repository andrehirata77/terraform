terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "terraformstate8rch0g"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}