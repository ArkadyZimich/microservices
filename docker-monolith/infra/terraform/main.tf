provider "google" {
  version = "3.60.0"
  project = "${var.project}"
  region  = "${var.region}"
}
resource "google_compute_instance" "app" {
  count = 3
  name         = "docker-host${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }
  metadata = {
    ssh-keys = "ArkadyZimich:${file(var.public_key_path)}"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default" 
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
