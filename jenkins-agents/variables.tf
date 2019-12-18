variable "resource_group_name" {
  description = "Name of the resource group to create"
  default     = "OE-Jenkins-terraform-poc"
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
  default     = "Standard_DS1_V2"
}

variable "oeadmin_ssh_pub_key" {
  description = "Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
}

variable "bionic_blob_uri" {
  default = "https://oejenkinswesteurope.blob.core.windows.net/disks/2019-November-21-jenkins-agent-ubuntu-18.04.vhd"
}
