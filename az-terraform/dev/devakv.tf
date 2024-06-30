# AKV 
# https://learn.microsoft.com/en-us/azure/key-vault/keys/quick-create-terraform?tabs=azure-cli

data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

resource "random_string" "akv-name" {
  length  = 3
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_key_vault" "dev-akv" {
  name                = "${lower(var.infra)}-akv-vault"
  resource_group_name = azurerm_resource_group.dev-state-rg.name
  tenant_id           = data.azuread_client_config.current.tenant_id
  location            = var.location
  sku_name            = var.sku_name

  # purge_protection_enabled = false
  enable_rbac_authorization  = true
  purge_protection_enabled   = true
  soft_delete_retention_days = 7
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id        = azurerm_key_vault.dev-akv.id
  tenant_id           = data.azuread_client_config.current.tenant_id
  object_id           = data.azuread_client_config.current.object_id
  key_permissions     = var.key_permissions
  secret_permissions  = var.secret_permissions
  storage_permissions = var.storage_permissions
}

# Create the Key Vault 'Admin User Group' Access Policy Group
resource "azurerm_key_vault_access_policy" "storage_mi_kv_access" {
  key_vault_id        = azurerm_key_vault.dev-akv.id
  tenant_id           = data.azuread_client_config.current.tenant_id
  object_id           = azurerm_user_assigned_identity.key_vault_admin.principal_id
  key_permissions     = var.key_permissions
  secret_permissions  = var.secret_permissions
  storage_permissions = var.storage_permissions
}

# CMK
# resource "azurerm_storage_account_customer_managed_key" "storage_key" {
#   storage_account_id = azurerm_storage_account.dev-state-sa.id
#   key_vault_id       = azurerm_key_vault.dev-akv.id
#   key_name           = azurerm_key_vault_key.dev-key.name
# }

resource "azurerm_key_vault_key" "dev-key" {
  name = "${lower(var.infra)}-key-${random_string.akv-name.result}"
  # name            = "${lower(var.infra)}-key-${formatdate("YYYYMMDD-hhmm", timestamp())}"
  key_vault_id = azurerm_key_vault.dev-akv.id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_ops
  # expiration_date = time_offset.offset
  expiration_date = time_offset.offset.rfc3339

  depends_on = [
    azurerm_key_vault_access_policy.storage,
    azurerm_key_vault.dev-akv
  ]

  lifecycle {
    # create_before_destroy = false
    create_before_destroy = true
  }
}

resource "null_resource" "cmk_replacement_trigger" {
  triggers = {
    today = formatdate("YYYYMMDD", timestamp())
  }
}

resource "time_offset" "offset" {
  offset_days = 100

  lifecycle {
    replace_triggered_by = [null_resource.cmk_replacement_trigger]
  }
}
