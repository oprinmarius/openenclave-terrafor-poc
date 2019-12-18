module "jenkins-master" {
    source              = "Azure/compute/azurerm"
    location            = "${var.location}"
    vm_os_simple        = "UbuntuServer"
    public_ip_dns       = ["${var.dns_name}"] // change to a unique name per datacenter region
    vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
    ssh_key             = "${var.oeadmin_ssh_pub_key}"
    custom_data         = "${file("${path.module}/cloud-init.tpl")}"
}