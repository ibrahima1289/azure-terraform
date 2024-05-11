##################### Important ##############
# Backend should be set only from local to preserve the state file
# Otherwise, provide state file placehoder before deployinh backend resources
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/service_principal_configuration

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

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

provider "azuread" {

}
