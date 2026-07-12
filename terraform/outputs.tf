output "metabase_url" {
  value       = google_cloud_run_v2_service.metabase.uri
  description = "The public URL to access your Metabase instance"
}

output "database_private_ip" {
  value       = google_sql_database_instance.metabase_db.private_ip_address
  description = "The private IP address of the Cloud SQL instance"
}

output "database_instance_name" {
  value       = google_sql_database_instance.metabase_db.name
  description = "The name of the Cloud SQL instance"
}
