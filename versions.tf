provider "azurerm" {
  features {}
  subscription_id = "af209cc5-f115-4194-8a2e-f83856da968a"
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
    subscription_id      = "5945e69f-65ac-4876-bbf4-4a0fa9753c05"
    resource_group_name  = "dana"
    storage_account_name = "hackaton870"
    container_name       = "tfstate"
    key                  = "zurimoni.tfstate"
  }
}
