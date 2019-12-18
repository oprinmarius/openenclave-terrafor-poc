module "lb-1804acc" {
  source              = "modules/loadbalancer"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "1804acc"
  frontend_subnet_id                     = "${module.network.vnet_subnets[0]}"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.1.6"


  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}

module "lb-1604acc" {
  source              = "modules/loadbalancer"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "1604acc"
  frontend_subnet_id                     = "${module.network.vnet_subnets[0]}"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.1.7"


  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}

module "lb-1804nonacc" {
  source              = "modules/loadbalancer"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "1804nonacc"
  frontend_subnet_id                     = "${module.network.vnet_subnets[0]}"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.1.8"


  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}

module "lb-2016acc" {
  source              = "modules/loadbalancer"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "2016acc"
  frontend_subnet_id                     = "${module.network.vnet_subnets[0]}"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.1.9"


  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}

module "lb-2016sgx" {
  source              = "modules/loadbalancer"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "2016sgx"
  frontend_subnet_id                     = "${module.network.vnet_subnets[0]}"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.1.10"


  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}

module "lb-2016nonsgx" {
  source              = "modules/loadbalancer"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "2016nonsgx"
  frontend_subnet_id                     = "${module.network.vnet_subnets[0]}"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.1.11"


  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}