terraform {
  backend "azurerm" {
    resource_group_name  = "OE-Jenkins-CI-westeurope"
    storage_account_name = "oejenkinswesteurope"
    container_name       = "tfstate"
    key                  = "oe-terraform-test/jenkins-master/terraform.tfstate"
  }
}

provider "azurerm" {
  version = "~> 1.0"
}
