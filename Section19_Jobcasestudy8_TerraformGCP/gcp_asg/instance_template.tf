resource "google_compute_instance_template" "default" {
  name        = "mydefaulttemplate"
  description = "This template is defalt"

  tags = ["foo", "bar"]

  labels = {
    environment = "dev"
  }

  instance_description = "description assigned to instances"
  machine_type         = "${var.machine_type}"
  //can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image = "ubuntu-os-cloud/ubuntu-1604-lts"
    auto_delete  = true
    boot         = true
  }

  metadata
  {
    startup-script = "${file("${var.startup_script}")}" # get the startup_script from a file which is  bootstrap script
    sshKeys = "ubuntu:${file(var.gce_ssh_pub_key_file)}"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }

  }


}
