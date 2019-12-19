variable "resource_group_name" {
  description = "Name of the resource group to create VMSS in"
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "westeurope"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."

  default = {
    environment = "Test"
    application = "Openenclave"
  }
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_DC2s"
}

variable "oeadmin_ssh_pub_key" {
  description = "Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
}

variable "blob_uri" {
  description = "Custom VHD link"
}

variable "agent_type" {
  description = "Jenkins Agent type"
  default = "bionic"
}

variable "os_type" {
  description = "OS type: Linux or Windows"
  default = "Linux"
}

variable "os_size_gb" {
  description = "OS disk size in GB"
  default = 50
}

variable "data_disk_size_gb" {
  description = "Data disk size in GB"
  default = 100
}

variable "jenkins_master_dns" {
  description = "Jenkins Master DNS name"
}

variable "cloud_init_configfile" {
  description = "Cloud-init config file path"
}

variable "subnet_id" {
  description = "Subnet id"
}

variable "vnet_name" {
  description = "VNET name"
}

variable "admin_password" {
  description = "Password for Windows VMS, default for testing"
  default     = "Testing12345!"
}