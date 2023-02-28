provider "azurerm" {
  features {}
}

terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.40.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "29f045e3-3e99-4b8b-8e2c-d2aee6863859"
    resource_group_name  = "cp-hub-tfstate-rg"
    storage_account_name = "cphubterraformstatesa"
    container_name       = "tfstate"
    key                  = "zurimoni.tfstate"
  }
}
