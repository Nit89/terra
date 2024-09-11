terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "d92db358-ab17-4414-b7ca-ad88d9c02096"
}

