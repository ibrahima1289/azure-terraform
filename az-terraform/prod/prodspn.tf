data "azuread_client_config" "current" {}

# Create the Service Principle
resource "azuread_service_principal" "spn_prod" {
  application_id               = azuread_application.spn_prod.application_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

# Create the Application
resource "azuread_application" "spn_prod" {
  display_name = "app_prod"
  owners                       = [data.azuread_client_config.current.object_id]
}

# Assign role to the SPN
resource "azurerm_role_assignment" "spn_prod" {
  scope                        = "/subscriptions/xxx/" # Add the subscription id
  role_definition_name         = "Contributor" 
  principal_id                 = azuread_service_principal.spn_prod.object_id # SPN id
}

# Passwd + Rotation
resource "time_rotating" "spn_prod" {
  rotation_days = 3
}

resource "random_string" "sp-pass" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "sp-pass" {
  service_principal_id         = azuread_service_principal.spn_prod.object_id
  rotate_when_changed          = {
    rotation                   = time_rotating.spn_prod.id
  }
}