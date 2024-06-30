# use case
variable "infra" {
  type        = string
  description = "Dev Infra"
  default     = "dev"
}
# environment
variable "environment" {
  type        = string
  description = "Dev Environment"
  default     = "dev"
}
variable "tenant_id" {
  type        = string
  description = "Azure Tenant"
  default     = "af3ec258-22d0-4328-9742-8a76938d841c"
}
# azure region
variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "name" {
  description = "Storage account name"
  type        = string
  default     = null
}

# variable "resource_group_name" {
#   description   = "Resource group to create the resource"
#   type          = string
# }

variable "account_kind" {
  description = "Kind of account: BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  description = "Tier for storage account (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type used."
  type        = string
  default     = "LRS"
}

variable "access_tier" {
  description = "Defines the access tier for account_kind"
  type        = string
  default     = "Cool"

  validation {
    condition     = (contains(["hot", "cool", "HOT", "COOL"], lower(var.access_tier)))
    error_message = "The account_tier Must be either \"Hot\" or \"Cool\"."
  }
}

# AKV Variables
variable "sku_name" {
  type        = string
  description = "SKU of AKV to be created."
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The sku_name must be: standard or premium."
  }
}

variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default     = ["List", "Create", "Delete", "Get", "Purge", "Recover", "Update"]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Get", "Set"]
}

variable "storage_permissions" {
  type        = list(string)
  description = "List of storage account permissions."
  default     = ["List", "Get", "RegenerateKey"]
}

variable "key_type" {
  description = "The key type to be created."
  default     = "RSA"
  type        = string
  validation {
    condition     = contains(["EC", "EC-HSM", "RSA", "RSA-HSM"], var.key_type)
    error_message = "The key_type must be one of the following: EC, EC-HSM, RSA, RSA-HSM."
  }
}

variable "key_size" {
  type        = number
  description = "The size in bits of the key to be created."
  default     = 2048
}

variable "key_ops" {
  type        = list(string)
  description = "The permitted JSON web key operations of the key to be created."
  default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}
