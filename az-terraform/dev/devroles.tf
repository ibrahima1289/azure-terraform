# Roles to be assigned

# resource "azurerm_role_assignment" "akv_admin" {
#   scope                = azurerm_key_vault.dev-akv.id
#   role_definition_name = "Key Vault Administrator"
#   principal_id         = azurerm_user_assigned_identity.key_vault_admin.principal_id
# }

# resource "azurerm_role_assignment" "akv_spn_contributor" {
#   scope                = azurerm_key_vault.dev-akv.id
#   role_definition_name = "Key Vault Contributor"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

# resource "azurerm_role_assignment" "akv_sa_crypto" {
#   scope                = azurerm_key_vault.dev-akv.id
#   role_definition_name = "Key Vault Crypto Service Encryption User"
#   principal_id         = azurerm_storage_account.dev-state-sa.identity.0.principal_id
# }

# resource "azurerm_role_assignment" "blob_data" {
#   scope                = azurerm_storage_account.dev-state-sa.id
#   role_definition_name = "Storage Blob Data Owner"
#   principal_id         = data.azurerm_client_config.current.object_id
# }
