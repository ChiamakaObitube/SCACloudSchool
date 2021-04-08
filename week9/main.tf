provider "google" {
  project = "probable-dream-310003"
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

resource "google_compute_subnetwork" "" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.sca-network.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "vpc-network" {
  name                    = "sca-network"
  auto_create_subnetworks = false
}