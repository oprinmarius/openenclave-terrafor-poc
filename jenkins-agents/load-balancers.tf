module "lb-1804acc" {
  source              = "modules/loadbalancer"
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
  source              = "modules/loadbalancer"
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

module "lb-1804nonacc" {
  source              = "modules/loadbalancer"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  prefix              = "1804nonacc"

  remote_port = {
    ssh = ["Tcp", "22"]
  }

  lb_port = {
    http = ["80", "Tcp", "80"]
  }
}

#module "lb-2016acc" {
#  source              = "modules/loadbalancer"
#  resource_group_name = "${var.resource_group_name}"
#  location            = "${var.location}"
#  prefix              = "2016acc"
#
#  remote_port = {
#    ssh = ["Tcp", "22"]
#  }
#
#  lb_port = {
#    http = ["80", "Tcp", "80"]
#  }
#}
#
#module "lb-2016sgx" {
#  source              = "modules/loadbalancer"
#  resource_group_name = "${var.resource_group_name}"
#  location            = "${var.location}"
#  prefix              = "2016sgx"
#
#  remote_port = {
#    ssh = ["Tcp", "22"]
#  }
#
#  lb_port = {
#    http = ["80", "Tcp", "80"]
#  }
#}
#
#module "lb-2016nonsgx" {
#  source              = "modules/loadbalancer"
#  resource_group_name = "${var.resource_group_name}"
#  location            = "${var.location}"
#  prefix              = "2016nonsgx"
#
#  remote_port = {
#    ssh = ["Tcp", "22"]
#  }
#
#  lb_port = {
#    http = ["80", "Tcp", "80"]
#  }
#}