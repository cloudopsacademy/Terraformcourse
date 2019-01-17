provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
  }
resource "azurerm_resource_group" "rgtest" {
    name     = "${var.resource_group}"
    location = "${var.location}"
  }
/*resource "azurerm_autoscale_setting" "rgtest" {
      name                = "myAutoscaleSetting"
      enabled             = true
      resource_group_name = "${azurerm_resource_group.rgtest.name}"
      location            = "${var.location}"
      target_resource_id  = "${azurerm_virtual_machine_scale_set.rgtest.id}"
    profile {
      name = "autoscaling"
      capacity {
        default = 2
        minimum = 2
        maximum = 2
                }
           }
  }*/
############## Storage Account ###############################
#When you are using Unmanaged Disks
/*
resource "azurerm_storage_account" "stor" {
  name                     = "renustor"
  location                 = "${var.location}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.storage_replication_type}"
}
*/



################## Virtual Network ##############################

resource "azurerm_virtual_network" "rgtest" {
  name                = "${var.virtual_network_name}"
  location            = "${var.location}"
  address_space       =["10.0.0.0/16"]
  resource_group_name = "${azurerm_resource_group.rgtest.name}"
}

###################### Subnet ###################################

resource "azurerm_subnet" "rgtest" {
  name                 = "${var.rg_prefix}subnet"
  virtual_network_name = "${azurerm_virtual_network.rgtest.name}"
  resource_group_name  = "${azurerm_resource_group.rgtest.name}"
  address_prefix       = "10.0.2.0/24"               #"${var.subnet_prefix}"
  depends_on           = ["azurerm_virtual_network.rgtest"]

}

resource "azurerm_public_ip" "rgtest" {
  name                         = "PublicIPForLB"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rgtest.name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_lb" "rgtest" {
  name                = "TestLoadBalancer"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rgtest.name}"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = "${azurerm_public_ip.rgtest.id}"
  }
}


resource "azurerm_lb_backend_address_pool" "backend_pool" {
  resource_group_name = "${azurerm_resource_group.rgtest.name}"
  loadbalancer_id     = "${azurerm_lb.rgtest.id}"
  name                = "BackendPool1"
}

##################Load Balancer Nat rules ######################

resource "azurerm_lb_nat_pool" "lbnatpool" {
  count                          = 3
  resource_group_name            = "${azurerm_resource_group.rgtest.name}"
  name                           = "ssh"
  loadbalancer_id                = "${azurerm_lb.rgtest.id}"
  protocol                       = "Tcp"
  frontend_port_start            = 1000
  frontend_port_end              = 2000
  backend_port                   = 22
  frontend_ip_configuration_name = "LoadBalancerFrontEnd" #LoadBalancerFrontEnd
}
####################### Probe Rule ##################
resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${azurerm_resource_group.rgtest.name}"
  loadbalancer_id     = "${azurerm_lb.rgtest.id}"
  name                = "tcpProbe"
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 3
}

resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = "${azurerm_resource_group.rgtest.name}"
  loadbalancer_id                = "${azurerm_lb.rgtest.id}"
  name                           = "LBRule"
  protocol                       = "tcp"
  frontend_port                  = 80     #"${var.application_port}"
  backend_port                   = 80     #"${var.application_port}"
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
#  enable_floating_ip             = false
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.backend_pool.id}"
  idle_timeout_in_minutes        = 5
  probe_id                       = "${azurerm_lb_probe.lb_probe.id}"
  depends_on                     = ["azurerm_lb_probe.lb_probe"]
}

############################ Virtual Machine #########################
############################ Scale Set ###############################

resource "azurerm_virtual_machine_scale_set" "rgtest" {
  name                = "vmscaleset"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rgtest.name}"
  upgrade_policy_mode = "Manual"
  count                = 3

  sku {
    name     = "Standard_DS1_v2"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_profile_os_disk {
    name          = ""
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
 }

  os_profile {
    computer_name_prefix  = "${var.hostname}"
    admin_username        = "azureuser"
    admin_password        = "1_Azureuser"
  }

  os_profile_linux_config {
        disable_password_authentication = false
  #      ssh_keys {
  #          path     = "/home/azureuser/.ssh/authorized_keys"
  #          key_data = "${file("~/.ssh/demo_key.pub")}"
  #    }

}

 network_profile {
   name    = "testnwpro"
   primary = true

   ip_configuration {
     name                                   = "TestIPConfiguration"
     subnet_id                              = "${azurerm_subnet.rgtest.id}"
     load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.backend_pool.id}"]
     load_balancer_inbound_nat_rules_ids    = ["${element(azurerm_lb_nat_pool.lbnatpool.*.id, count.index)}"]

   }
 }
}

resource "azurerm_mysql_server" "rgtest" {
  name                = "mysql-serversrss"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rgtest.name}"

  sku {
    name = "B_Gen4_1"
    capacity = 1
    tier = "Basic"
    family = "Gen4"

  }

  storage_profile {
    storage_mb = 5120
    backup_retention_days = 7
    geo_redundant_backup = "Disabled"

  }

  administrator_login = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"
  version = "5.7"
  ssl_enforcement = "Enabled"
}

#firewall Rules to provide the access to the mysql server.
resource "azurerm_mysql_firewall_rule" "rgtest" {
  name                = "office"
  resource_group_name = "${azurerm_resource_group.rgtest.name}"
  server_name         = "${azurerm_mysql_server.rgtest.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
