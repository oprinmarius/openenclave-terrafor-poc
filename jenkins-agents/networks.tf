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

module "network-1804nonacc" {
  source              = "Azure/network/azurerm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  vnet_name           = "vnet-1804nonacc"
}

module "network-2016acc" {
  source              = "Azure/network/azurerm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  vnet_name           = "vnet-2016acc"
}

module "network-2016sgx" {
  source              = "Azure/network/azurerm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  vnet_name           = "vnet-2016sgx"
}

module "network-2016nonsgx" {
  source              = "Azure/network/azurerm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  vnet_name           = "vnet-2016nonsgx"
}