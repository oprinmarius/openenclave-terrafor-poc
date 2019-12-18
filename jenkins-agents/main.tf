data "terraform_remote_state" "jenkins-master" {
  backend = "azurerm"

  config = {
    storage_account_name = "oejenkinswesteurope"
    resource_group_name  = "OE-Jenkins-CI-westeurope"
    container_name       = "tfstate"
    key                  = "oe-terraform-test/jenkins-master/terraform.tfstate"
  }
}

data "template_cloudinit_config" "bionic" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-init.tpl",
      {
        jenkins_master_dns  = data.terraform_remote_state.jenkins-master.outputs.jenkins_master_dns
        location            = var.location
        oeadmin_ssh_pub_key = file(var.oeadmin_ssh_pub_key)
      }
    )
  }
}

resource "azurerm_image" "bionic-image" {
  name                = "terraform-bionic"
  location            = var.location
  resource_group_name = data.terraform_remote_state.jenkins-master.outputs.resource_group_name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = var.bionic_blob_uri
    size_gb  = 30
  }
}

resource "azurerm_virtual_machine_scale_set" "agents-bionic" {
  name                = "agents-bionic"
  location            = var.location
  resource_group_name = data.terraform_remote_state.jenkins-master.outputs.resource_group_name
  upgrade_policy_mode = "Manual"

  sku {
    name     = "Standard_DC2s"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    id = azurerm_image.bionic-image.id
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
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "bionic"
    admin_username       = "azureuser"
    custom_data          = data.template_cloudinit_config.bionic.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file(var.oeadmin_ssh_pub_key)
    }
  }

  network_profile {
    name    = data.terraform_remote_state.jenkins-master.outputs.vnet_name
    primary = true

    ip_configuration {
      name      = "BionicIPConfiguration"
      subnet_id = data.terraform_remote_state.jenkins-master.outputs.vnet_subnets[0]
      primary   = true
    }
  }

  tags = var.tags
}
