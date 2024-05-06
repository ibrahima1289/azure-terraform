data "azuread_client_config" "current" {}

# Create the Service Principle
resource "azuread_service_principal" "spn_backend" {
  application_id               = azuread_application.spn_backend.application_id
  owners                       = [data.azuread_client_config.current.object_id]
  app_role_assignment_required = true
}

# Create the Application
resource "azuread_application" "spn_backend" {
  display_name = "app_backend"
  owners       = [data.azuread_client_config.current.object_id]
}

# Assign role to the SPN
# resource "azurerm_role_assignment" "spn_backend" {
#   scope                        = data.azurerm_subscription.current.id # Add the subscription id
#   role_definition_name         = "Contributor" 
#   principal_id                 = azuread_service_principal.spn_backend.object_id # SPN id
# }

# Passwd + Rotation
resource "time_rotating" "spn_backend" {
  rotation_days = 3
}

resource "random_string" "sp-pass" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "sp-pass" {
  service_principal_id = azuread_service_principal.spn_backend.object_id
  rotate_when_changed = {
    rotation = time_rotating.spn_backend.id
  }
}