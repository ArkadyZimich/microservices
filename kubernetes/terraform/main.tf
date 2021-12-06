provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
}

resource "google_container_cluster" "primary" {
  name               = "${var.name}"
  initial_node_count = 2

  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    machine_type = "${var.machine_type}"
    disk_size_gb = "${var.disk_size_gb}"
  }
}

resource "google_compute_firewall" "gke-nodeports" {
  name = "gke-nodeports"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}
