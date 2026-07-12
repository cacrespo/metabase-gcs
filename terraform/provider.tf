terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
  backend "gcs" {
    # The bucket name is injected dynamically during 'terraform init' using -backend-config
    prefix = "metabase"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
