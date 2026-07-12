# Private PostgreSQL database instance
resource "google_sql_database_instance" "metabase_db" {
  name             = "metabase-db-instance"
  database_version = "POSTGRES_17"
  region           = var.region

  settings {
    # db-custom-1-3840 provides 1 vCPU and 3.75 GB RAM.
    tier    = "db-custom-1-3840"
    edition = "ENTERPRISE"

    disk_size = 10
    disk_type = "PD_SSD"

    backup_configuration {
      enabled    = true
      start_time = "03:00"
    }

    ip_configuration {
      ipv4_enabled    = false # Disables public IP for maximum security 🔒
      private_network = google_compute_network.metabase_vpc.id
    }
  }

  # Ensure VPC Peering is active before provisioning the DB
  depends_on = [google_service_networking_connection.private_vpc_connection]

  deletion_protection = true
}

# Internal Metabase database
resource "google_sql_database" "metabase_database" {
  name     = "metabase-metadata"
  instance = google_sql_database_instance.metabase_db.name
}

# Configure the password for the 'metabase_user' in Cloud SQL
resource "google_sql_user" "metabase_user" {
  name     = "metabase_user"
  instance = google_sql_database_instance.metabase_db.name
  password = data.google_secret_manager_secret_version.db_pass_version.secret_data
}
