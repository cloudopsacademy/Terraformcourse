# FireWall Resource for Allowing Access : SSH, HTTP & HTTPS

resource "google_compute_firewall" "ssh-from-office"
{
  name = "allow-ssh-office"
  network = "default"
    allow
    {
      protocol = "tcp"
      ports = ["22"]
    }
  source_ranges = ["${var.ssh_cidr}"]
}


resource "google_compute_firewall" "http-https"
{
  name = "httphttps"
  network = "default"
  allow
  {
    protocol = "tcp"
    ports = ["80","443","3306","4444","4567","4568"]
  }
  source_ranges = ["0.0.0.0/0"]

}
