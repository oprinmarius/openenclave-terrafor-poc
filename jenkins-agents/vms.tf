# VM Configuration lives here
module "vmss-1804acc" {
  source                                 = "Azure/vmss-cloudinit/azurerm"
  resource_group_name                    = "${var.resource_group_name}"
  cloudconfig_file                       = "${path.module}/cloud-init.tpl"
  location                               = "${var.location}"
  vm_size                                = "${var.vm_size_acc}"
  admin_username                         = "${var.oeadmin}"
  admin_password                         = "ComplexPassword"
  ssh_key                                = "~/.ssh/id_rsa.pub"
  nb_instance                            = 2
  vm_os_simple                           = "UbuntuServer"
  vnet_subnet_id                         = "${module.network-1804acc.vnet_subnets[0]}"
  load_balancer_backend_address_pool_ids = "${module.lb-1804acc.azurerm_lb_backend_address_pool_id}"
}