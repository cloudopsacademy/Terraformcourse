# This file contains variables that are used in project.
# If the value of these variables is not defined in terraform.tfvars file they be asked at the runtime

variable  "pname"{} # Project Name
variable "project_id"{}  # Project id that you created
variable "creds_file"{} # Json file downloaded from googlec cloud which will provide access to Gcloud Resources
variable  "region"{} # Geographical Region in which we have to create the resources

variable  "machine_type"{} # The Capacity of VM that we wnat to create
variable "startup_script"{} # File which will be used as bootstrap script
variable "count" {
  default = "1"
}

variable "ssh_cidr" {
  default = "0.0.0.0/0"
}

variable "gce_ssh_pub_key_file" {
  default = ""
}
variable "db_version" {
  default = ""
}
variable "sql_tier" {
  default = "db-f1-micro"
}

variable "db_disk_size" {
  default = "10"
}
variable "db_user_name" {
  default = "root"
}
variable "db_user_password" {
  default = "test123"
}
variable "authorized_network" {
  default = "0.0.0.0/0"
}
variable "connect_retry_interval" {
  default = "60"
}

variable "auto_create_subnetworks" {
  type        = "string"
  default     = "true"
  description = "Auto-creation of the associated subnet"
}
