data "azuread_client_config" "current" {}

# Create the Service Principle
resource "azuread_service_principal" "InfraSPN" {
  application_id               = azuread_application.InfraSPN.application_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

# Create the Application
resource "azuread_application" "InfraSPN" {
  display_name = "InfraSPN"
  owners                       = [data.azuread_client_config.current.object_id]
}

# Assign role to the SPN
resource "azurerm_role_assignment" "InfraSPN" {
  scope                        = "/subscriptions/xxx/" # Add the subscription id
  role_definition_name         = "Contributor" 
  principal_id                 = azuread_service_principal.InfraSPN.object_id # SPN id
}

# Passwd + Rotation
resource "time_rotating" "InfraSPN" {
  rotation_days = 3
}

resource "random_string" "sp-pass" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "sp-pass" {
  service_principal_id         = azuread_service_principal.InfraSPN.object_id
  rotate_when_changed          = {
    rotation                   = time_rotating.InfraSPN.id
  }
}