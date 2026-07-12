# Retrieve the secret already created in Secret Manager for the database password
data "google_secret_manager_secret" "db_pass" {
  secret_id = "metabase-db-password"
}

# Retrieve the password value saved in the secret
data "google_secret_manager_secret_version" "db_pass_version" {
  secret = data.google_secret_manager_secret.db_pass.id
}
