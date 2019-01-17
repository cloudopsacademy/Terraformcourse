variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "resource_group" {}

variable "rg_prefix" {
#  description = "The shortened abbreviation to represent your resource group that will go on the front of some resources."
  default     = "rg"
}

variable "hostname" {
#       hostname = "testvm"
         default = "myvm"
}

#variable "dns_name" {
#  description = " Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
#}

#variable "lb_ip_dns_name" {
#  description = "DNS for Load Balancer IP"
#}

variable "location" {
#  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "eastus"
}

variable "virtual_network_name" {
#  description = "The name for the virtual network."
  default     = "vnet"
}

/*variable "address_space" {
#  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}
*/
/* variable "subnet_prefix" {
#  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}
*/
variable "storage_account_tier" {
#  description = "Defines the Tier of storage account to be created. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
#  description = "Defines the Replication Type to use for this storage account. Valid options include LRS, GRS etc."
  default     = "LRS"
}

variable "vm_size" {
#  description = "Standard_DS1_v2"
  default     = "Standard_DS1_v2"
}

variable "image_publisher" {
#  description = "Canonical"
  default     = "Ubuntu"
}

variable "image_offer" {
#  description = "UbuntuServer"
  default     = "UbuntuServer"
}

variable "image_sku" {
#  description = "16.04.0-LTS"
  default     = "16.04.0-LTS"
}

variable "image_version" {
#  description = "latest"
  default     = "latest"
}

#variable "admin_username" {
#  description = "administrator user name"
#  default     = "vmadmin"
#}

#variable "admin_password" {
#  description = "administrator password (recommended to disable password auth)"
#}
