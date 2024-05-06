# use case
variable "infra" {
  type        = string
  description = "Backend Infra"
  default     = "backend"
}
# environment
variable "environment" {
  type        = string
  description = "Backend Environment for TF state Files"
  default     = "backend"
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
  description = "Replication typr used."
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