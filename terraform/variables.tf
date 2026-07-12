variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region where resources will be deployed"
  type        = string
  default     = "us-central1"
}

variable "metabase_image" {
  description = "Docker image for Metabase"
  type        = string
  default     = "metabase/metabase:v0.62.4"
}

variable "mb_site_url" {
  description = "Base URL of the Metabase site (optional, to configure MB_SITE_URL)"
  type        = string
  default     = ""
}
