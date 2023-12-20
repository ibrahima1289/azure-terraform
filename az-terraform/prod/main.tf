# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
     azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.30.0"
    }
  }

  backend "azurerm" {
    subscription_id      = data.azurerm_subscription.current.id
    resource_group_name  = "backend-state-rg"
    storage_account_name = "backendtf..."
    container_name       = "backend-tfstate"
    key                  = "prod.tfstate"
  }

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}