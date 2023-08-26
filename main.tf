# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

#Creates resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-eastus"
  location = "eastus"
}

#Creates virtual network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-eastus"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.1.0.0/16"]
}

#Create subnet
resource "azurerm_subnet" "main" {
  name = "subnet-eastus-1"
  virtual_network_name = azurerm_virtual_network.main.name 
  resource_group_name = azurerm_resource_group.main.name 
  address_prefixes = ["10.1.0.0/24"]
}
