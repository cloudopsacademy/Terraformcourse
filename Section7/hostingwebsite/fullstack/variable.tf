# Project wide variable
variable "PROJECT_NAME" {}
# Varibles for the Providers
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}

# RDS variables
variable "RDS_CIDR" {}
variable "DB_INSTANCE_CLASS" {}
variable "RDS_ENGINE" {}
variable "ENGINE_VERSION" {}
variable "BACKUP_RETENTION_PERIOD" {}
variable "PUBLICLY_ACCESSIBLE" {}
variable "RDS_USERNAME" {}
variable "RDS_PASSWORD" {}
variable "RDS_ALLOCATED_STORAGE" {}

# Ec2 /Autoscaling Variables
variable "SSH_CIDR_WEB_SERVER" {}
variable "SSH_CIDR_APP_SERVER" {}
variable "WEB_SERVER_INSTANCE_TYPE"{}
variable "APP_SERVER_INSTANCE_TYPE"{}
variable "USER_DATA_FOR_WEBSERVER" {}
variable "USER_DATA_FOR_APPSERVER" {}
variable "PEM_FILE_APPSERVERS" {}
variable "PEM_FILE_WEBSERVERS" {}

# VPC Variables
variable "VPC_CIDR_BLOCK" {}
variable "VPC_PUBLIC_SUBNET1_CIDR_BLOCK" {}
variable "VPC_PUBLIC_SUBNET2_CIDR_BLOCK" {}
variable "VPC_PRIVATE_SUBNET1_CIDR_BLOCK" {}
variable "VPC_PRIVATE_SUBNET2_CIDR_BLOCK" {}
