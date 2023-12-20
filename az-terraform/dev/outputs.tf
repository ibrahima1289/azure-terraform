########################## Service Principal ##########################
output "object_id" {
  value       = azuread_service_principal.dev_spn.object_id
}
output "client_id" {
  value       = azuread_application.dev_spn.application_id
}

# output "sp-pass" {
#     # value     = azuread_service_principal_password.sp-pass.value
#     value     = random_string.sp-pass.result
#     sensitive = true
# }

########################## Storage Account ###########################
output "terraform_state_resource_group_name" {
  value = azurerm_resource_group.dev-state-rg.name
}
output "terraform_state_storage_account" {
  value = azurerm_storage_account.dev-state-sa.name
}
output "terraform_state_storage_container" {
  value = azurerm_storage_container.dev-container.name
}
