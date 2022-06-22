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
    key_vault {
      purge_soft_delete_on_destroy = true
    }

  }
}
data "azurerm_client_config" "current" {}

resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}
resource "azurerm_resource_group" "rg-terraform" {
  name     = "rg-terraform"
  location = "East US"
}

resource "azurerm_storage_account" "sa-terraform" {
  name                     = "terraformstate${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.rg-terraform.name
  location                 = azurerm_resource_group.rg-terraform.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "sc-terraform" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa-terraform.name
  container_access_type = "private"
}
resource "azurerm_key_vault" "key_vault" {
  name                        = "keyvaultCCoE"
  location                    = azurerm_resource_group.rg-terraform.location
  resource_group_name         = azurerm_resource_group.rg-terraform.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey" 
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}