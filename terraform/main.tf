terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "mkstorage1621600706"
    container_name       = "tfstatedevops"
    key                  = "tfstatedevops.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  features {}
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "mkops" {
  name     = "mkops"
  location = "northeurope"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "mkops-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.mkops.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.mkops.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}


