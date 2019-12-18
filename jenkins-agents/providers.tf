terraform {
  backend "azurerm" {
    resource_group_name  = "OE-Jenkins-CI-westeurope"
    storage_account_name = "oejenkinswesteurope"
    container_name       = "tfstate"
    key                  = "oe-terraform-test/jenkins-agents/terraform.tfstate"
  }
}

provider "azurerm" {
  # https://github.com/SUSE/ha-sap-terraform-deployments/issues/188
  version = "<= 1.33"
}
