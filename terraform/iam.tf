# 1. Create a dedicated Service Account for Cloud Run
resource "google_service_account" "metabase_runner" {
  account_id   = "metabase-runner"
  display_name = "Service Account to run Metabase on Cloud Run"
}

# 2. Assign Secret Accessor role so Cloud Run can read the DB password
resource "google_secret_manager_secret_iam_member" "secret_accessor" {
  secret_id = data.google_secret_manager_secret.db_pass.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.metabase_runner.email}"
}

# 3. Assign Cloud SQL Client role to the Service Account
resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.metabase_runner.email}"
}

# 4. Allow public access to Metabase (optional but common to start)
# Note: If your organization blocks public access (allUsers) via organization policies
# (iam.allowedPolicyMemberDomains), this step will fail and you must create a temporary exception
# or use a Load Balancer.
resource "google_cloud_run_v2_service_iam_member" "public_access" {
  name     = google_cloud_run_v2_service.metabase.name
  location = google_cloud_run_v2_service.metabase.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
