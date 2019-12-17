# VM Configuration lives here
module "vmss-1804acc" {
  source                                 = "Azure/vmss-cloudinit/azurerm"
  vmscaleset_name                        = "1804acc"
  resource_group_name                    = "${var.resource_group_name}"
  cloudconfig_file                       = "${path.module}/cloud-init.tpl"
  location                               = "${var.location}"
  vm_size                                = "${var.vm_size_acc}"
  admin_username                         = "${var.oeadmin}"
  admin_password                         = "ComplexPassword"
  ssh_key                                = "~/.ssh/id_rsa.pub"
  nb_instance                            = 1
  vm_os_publisher                        = "Canonical"
  vm_os_offer                            = "UbuntuServer"
  vm_os_sku                              = "18.04-LTS"
  vm_os_version                          = "latest"
  vnet_subnet_id                         = "${module.network-1804acc.vnet_subnets[0]}"
  load_balancer_backend_address_pool_ids = "${module.lb-1804acc.azurerm_lb_backend_address_pool_id}"
}

# VM Configuration lives here
module "vmss-1604acc" {
  source                                 = "Azure/vmss-cloudinit/azurerm"
  vmscaleset_name                        = "1604acc"
  resource_group_name                    = "${var.resource_group_name}"
  cloudconfig_file                       = "${path.module}/cloud-init.tpl"
  location                               = "${var.location}"
  vm_size                                = "${var.vm_size_acc}"
  admin_username                         = "${var.oeadmin}"
  admin_password                         = "ComplexPassword"
  ssh_key                                = "~/.ssh/id_rsa.pub"
  nb_instance                            = 1
  vm_os_publisher                        = "Canonical"
  vm_os_offer                            = "confidential-compute-preview"
  vm_os_sku                              = "16.04-LTS"
  vm_os_version                          = "latest"
  vnet_subnet_id                         = "${module.network-1604acc.vnet_subnets[0]}"
  load_balancer_backend_address_pool_ids = "${module.lb-1604acc.azurerm_lb_backend_address_pool_id}"
}