# Create random storage name
resource "random_string" "sa-name" {
  length    = 10
  upper     = false
  numeric   = true
  lower     = true
  special   = false
}

# Create resource group for tf State File
resource "azurerm_resource_group" "dev-state-rg" {
  name                = "${lower(var.infra)}-state-rg"
  location            = var.location
}

# Create vnet for tf State File
resource "azurerm_virtual_network" "dev-vnet" {
  name                          = "${lower(var.infra)}-vnet"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.dev-state-rg.name
  address_space                 = ["10.0.1.0/16"]
}

# Create a Dev Storage Account 
resource "azurerm_storage_account" "dev-state-sa" { 
  name                          = "${lower(var.infra)}tf${random_string.sa-name.result}"
  resource_group_name           = azurerm_resource_group.dev-state-rg.name
  location                      = var.location
  account_kind                  = var.account_kind
  account_tier                  = var.account_tier
  access_tier                   = var.access_tier
  account_replication_type      = var.account_replication_type
  enable_https_traffic_only     = true
  depends_on                    = [azurerm_resource_group.dev-state-rg] 
   
#   lifecycle {
#     prevent_destroy = true
#   } 
 
  tags = {
    environment     = var.environment
  }
}

# Create a Container for the State File
resource "azurerm_storage_container" "tf-container" {  
  name                          = "${lower(var.infra)}-tfstate"
  storage_account_name          = azurerm_storage_account.dev-state-sa.name
  depends_on                    = [azurerm_storage_account.dev-state-sa]
}