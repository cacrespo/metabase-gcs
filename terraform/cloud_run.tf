resource "google_cloud_run_v2_service" "metabase" {
  name     = "metabase"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL" # Allows direct access to the Cloud Run URL (simplifies without needing a Load Balancer)

  template {
    service_account = google_service_account.metabase_runner.email

    scaling {
      min_instance_count = 1 # 1 for production / active demos to avoid "cold starts"
      max_instance_count = 4
    }

    containers {
      image = var.metabase_image

      ports {
        container_port = 3000
      }

      resources {
        limits = {
          cpu    = "2"
          memory = "4Gi"
        }
        cpu_idle          = true
        startup_cpu_boost = true
      }

      env {
        name  = "MB_DB_TYPE"
        value = "postgres"
      }
      env {
        name  = "MB_DB_PORT"
        value = "5432" # Standard PostgreSQL port
      }
      env {
        name  = "MB_DB_DBNAME"
        value = google_sql_database.metabase_database.name
      }
      env {
        name  = "MB_DB_USER"
        value = "metabase_user"
      }
      env {
        name = "MB_DB_HOST"
        # Dynamically obtains the private IP of the database created by Terraform
        value = google_sql_database_instance.metabase_db.private_ip_address
      }
      env {
        name = "MB_DB_PASS"
        value_source {
          secret_key_ref {
            secret  = data.google_secret_manager_secret.db_pass.secret_id
            version = "latest"
          }
        }
      }
      env {
        name  = "MB_SITE_URL"
        value = var.mb_site_url
      }
      env {
        name  = "JAVA_OPTS"
        value = "-Xmx3072m" # Configures Java heap leaving 1GB free for the container
      }
      env {
        name  = "JAVA_TIMEZONE"
        value = "UTC" # Maintains timezone consistency in reports
      }

      startup_probe {
        initial_delay_seconds = 10
        timeout_seconds       = 2
        period_seconds        = 5
        failure_threshold     = 15
        http_get {
          path = "/api/health"
          port = 3000
        }
      }
    }

    # Direct VPC Egress: connects Cloud Run directly to the VPC to access Cloud SQL via private IP
    vpc_access {
      network_interfaces {
        network    = google_compute_network.metabase_vpc.name
        subnetwork = google_compute_subnetwork.metabase_subnet.name
      }
      # PRIVATE_RANGES_ONLY: Only traffic to private IPs (like Cloud SQL) goes through the VPC.
      # Public internet traffic (e.g. querying external AI APIs) goes direct.
      # This eliminates the need for Cloud NAT and drastically reduces costs. 💡
      egress = "PRIVATE_RANGES_ONLY"
    }
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
    ]
  }
}
