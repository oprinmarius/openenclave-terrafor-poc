module "lb-1804acc" {
  source              = "Azure/loadbalancer/azurerm"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "1804acc"

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}

module "lb-1604acc" {
  source              = "Azure/loadbalancer/azurerm"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "1604acc"

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}