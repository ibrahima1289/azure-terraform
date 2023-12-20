########################## Service Principal ##########################
output "object_id" {
  value       = azuread_service_principal.prod_spn.object_id
}
output "client_id" {
  value       = azuread_application.prod_spn.application_id
}

# output "sp-pass" {
#     # value     = azuread_service_principal_password.sp-pass.value
#     value     = random_string.sp-pass.result
#     sensitive = true
# }

########################## Storage Account ###########################
output "terraform_state_resource_group_name" {
  value = azurerm_resource_group.prod-state-rg.name
}
output "terraform_state_storage_account" {
  value = azurerm_storage_account.prod-state-sa.name
}
output "terraform_state_storage_container" {
  value = azurerm_storage_container.prod-container.name
}
