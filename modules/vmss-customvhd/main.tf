locals {
   image_name = "terrafom-${var.agent_type}"
   vmss_name  = "agents${var.agent_type}"
   computer_name_prefix = var.agent_type
   ip_configuration_name = "${var.agent_type}IPConfiguration"
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile(var.cloud_init_configfile,
      {
        jenkins_master_dns  = var.jenkins_master_dns
        location            = var.location
        oeadmin_ssh_pub_key = file(var.oeadmin_ssh_pub_key)
        JENKINS_RUN         = "/var/run/jenkins"
        JENKINS_WORKSPACE   = "/var/jenkins"
        JENKINS_SECRET      = "secret"
        JENKINS_NODE_NAME   = "bionic"
        JENKINS_URL         = var.jenkins_master_dns
      }
    )
  }
}

resource "azurerm_image" "custom-image" {
  name                = local.image_name
  location            = var.location
  resource_group_name = var.resource_group_name

  os_disk {
    os_type  = var.os_type
    os_state = "Generalized"
    blob_uri = var.blob_uri
    size_gb  = var.os_size_gb
  }
}

resource "azurerm_virtual_machine_scale_set" "agents" {
  name                = local.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name
  upgrade_policy_mode = "Manual"

  sku {
    name     = var.vm_size
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    id = azurerm_image.custom-image.id
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = var.data_disk_size_gb
  }

  os_profile {
    computer_name_prefix = local.computer_name_prefix
    admin_username       = "oeadmin"
    custom_data          = data.template_cloudinit_config.config.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file(var.oeadmin_ssh_pub_key)
    }
  }

  network_profile {
    name    = var.vnet_name
    primary = true

    ip_configuration {
      name      = local.ip_configuration_name
      subnet_id = var.subnet_id
      primary   = true
    }
  }

  tags = var.tags
}
