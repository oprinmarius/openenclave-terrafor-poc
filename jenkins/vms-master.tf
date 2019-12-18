module "jenkins-master" {
    source              = "Azure/compute/azurerm"
    vm_hostname         = "jenkins-master"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    vm_os_publisher     = "Canonical"
    vm_os_offer         = "UbuntuServer"
    vm_os_sku           = "18.04-LTS"
    vm_os_version       = "latest"
    public_ip_dns       = ["${var.dns_name}"]
    vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
    ssh_key             = "${var.oeadmin_ssh_pub_key}"
    custom_data         = "${file("${path.module}/cloud-init.tpl")}"
}