# This file contains the provider type

provider "google"
{
  credentials = "${file("${var.creds_file}")}" # Get the Creds from a varible so that i dont have to hardcode it every time
  project = "${var.project_id}" # Project ID
  region = "${var.region}" # Region
}
# project wide ssh key
#resource "google_compute_project_metadata_item" "ubuntu" {
#  key = "ubuntu"
  #value = "${var.public_key}"
#}
