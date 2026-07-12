# 1. Create a dedicated VPC network for Metabase
resource "google_compute_network" "metabase_vpc" {
  name                    = "metabase-vpc"
  auto_create_subnetworks = false
}

# 2. Create a subnetwork for Cloud Run Direct VPC Egress
resource "google_compute_subnetwork" "metabase_subnet" {
  name          = "metabase-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.metabase_vpc.id
}

# 3. Reserve an internal IP range for Service Networking (peering with GCP services like Cloud SQL)
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "metabase-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.metabase_vpc.id
}

# 4. Establish the VPC Peering connection with Google Services (Service Networking)
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.metabase_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}
