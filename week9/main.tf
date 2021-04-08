provider "google" {
  project = "probable-dream-310003"
  region  = "europe-west1"
  zone    = "europe-west1-c"
}


resource "google_compute_network" "vpc_network" {
  name                    = "sca-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}
resource "google_compute_global_address" "private_ip_address" {

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {

  name   = "private-instance-${random_id.db_name_suffix.hex}"
  region = "europe-west1"
  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.vpc_network.id
    }
  }
}

