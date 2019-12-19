data "terraform_remote_state" "jenkins-master" {
  backend = "azurerm"

  config = {
    storage_account_name = "oejenkinswesteurope"
    resource_group_name  = "OE-Jenkins-CI-westeurope"
    container_name       = "tfstate"
    key                  = "oe-terraform-test/jenkins-master/terraform.tfstate"
  }
}

module "agents-bionic" {
  source = "../modules/vmss-customvhd"

  oeadmin_ssh_pub_key   = var.oeadmin_ssh_pub_key
  blob_uri              = var.bionic_blob_uri
  jenkins_master_dns    = data.terraform_remote_state.jenkins-master.outputs.jenkins_master_dns
  cloud_init_configfile = "${path.module}/cloud-init.tpl"
  subnet_id             = data.terraform_remote_state.jenkins-master.outputs.vnet_subnets[0]
  vnet_name             = data.terraform_remote_state.jenkins-master.outputs.vnet_name
  resource_group_name   = data.terraform_remote_state.jenkins-master.outputs.resource_group_name
  agent_type            = "BionicACC"
  vm_size               = var.vm_size_acc
}

module "agents-xenial" {
  source = "../modules/vmss-customvhd"
  oeadmin_ssh_pub_key   = var.oeadmin_ssh_pub_key
  blob_uri              = var.xenial_blob_uri
  jenkins_master_dns    = data.terraform_remote_state.jenkins-master.outputs.jenkins_master_dns
  cloud_init_configfile = "${path.module}/cloud-init.tpl"
  subnet_id             = data.terraform_remote_state.jenkins-master.outputs.vnet_subnets[0]
  vnet_name             = data.terraform_remote_state.jenkins-master.outputs.vnet_name
  resource_group_name   = data.terraform_remote_state.jenkins-master.outputs.resource_group_name
  agent_type            = "XenialACC"
  vm_size               = var.vm_size_acc
}


module "agents-xenial-nonsgx" {
  source = "../modules/vmss-customvhd"
  oeadmin_ssh_pub_key   = var.oeadmin_ssh_pub_key
  blob_uri              = var.xenial_blob_uri
  jenkins_master_dns    = data.terraform_remote_state.jenkins-master.outputs.jenkins_master_dns
  cloud_init_configfile = "${path.module}/cloud-init.tpl"
  subnet_id             = data.terraform_remote_state.jenkins-master.outputs.vnet_subnets[0]
  vnet_name             = data.terraform_remote_state.jenkins-master.outputs.vnet_name
  resource_group_name   = data.terraform_remote_state.jenkins-master.outputs.resource_group_name
  agent_type            = "Xenial-nonsgx"
  vm_size               = var.vm_size
}


module "agents-win2016ACC" {
  source = "../modules/vmss-customvhd-windows"
  oeadmin_ssh_pub_key   = var.oeadmin_ssh_pub_key
  blob_uri              = var.win2016ACC_blob_uri
  jenkins_master_dns    = data.terraform_remote_state.jenkins-master.outputs.jenkins_master_dns
  cloud_init_configfile = "${path.module}/cloud-init.tpl"
  subnet_id             = data.terraform_remote_state.jenkins-master.outputs.vnet_subnets[0]
  vnet_name             = data.terraform_remote_state.jenkins-master.outputs.vnet_name
  resource_group_name   = data.terraform_remote_state.jenkins-master.outputs.resource_group_name
  agent_type            = "win16ACC"
  vm_size               = var.vm_size_acc
}

module "agents-win2016SGX" {
  source = "../modules/vmss-customvhd-windows"
  oeadmin_ssh_pub_key   = var.oeadmin_ssh_pub_key
  blob_uri              = var.win2016SGX_blob_uri
  jenkins_master_dns    = data.terraform_remote_state.jenkins-master.outputs.jenkins_master_dns
  cloud_init_configfile = "${path.module}/cloud-init.tpl"
  subnet_id             = data.terraform_remote_state.jenkins-master.outputs.vnet_subnets[0]
  vnet_name             = data.terraform_remote_state.jenkins-master.outputs.vnet_name
  resource_group_name   = data.terraform_remote_state.jenkins-master.outputs.resource_group_name
  agent_type            = "win16SGX"
  vm_size               = var.vm_size_acc
}

module "agents-win2016nonSGX" {
  source = "../modules/vmss-customvhd-windows"
  oeadmin_ssh_pub_key   = var.oeadmin_ssh_pub_key
  blob_uri              = var.win2016nonSGX_blob_uri
  jenkins_master_dns    = data.terraform_remote_state.jenkins-master.outputs.jenkins_master_dns
  cloud_init_configfile = "${path.module}/cloud-init.tpl"
  subnet_id             = data.terraform_remote_state.jenkins-master.outputs.vnet_subnets[0]
  vnet_name             = data.terraform_remote_state.jenkins-master.outputs.vnet_name
  resource_group_name   = data.terraform_remote_state.jenkins-master.outputs.resource_group_name
  agent_type            = "16nonSGX"
  vm_size               = var.vm_size
}