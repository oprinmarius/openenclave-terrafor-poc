module "network-1804acc" {
  source              = "Azure/network/azurerm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  vnet_name           = "vnet-1804acc"
}

module "network-1604acc" {
  source              = "Azure/network/azurerm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  vnet_name           = "vnet-1604acc"
}