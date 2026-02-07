terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = "us-central1"
  credentials = var.credentials
}

module "gcs" {
  source = "./modules/gcs"

  # !Pass as a variable for modules/gcs/main.tf
  bucket_name_prefix = "taxi-data-lake"
  location           = var.location
}

module "bigquery" {
  source = "./modules/bigquery"

  dataset_id              = "taxi_dataset"
  location                = var.location
  description             = "Dataset for NYC taxi trip data"
  default_expiration_days = 90

  labels = {
    environment = "dev"
    project     = "taxi-data"
  }
}


# State migration: map old resource addresses to new module addresses.
# These blocks can be removed after everyone has applied the migration.

# NOTE: This is critical. Without these "moved" blocks, TF will assume that
# the old resource was removed and re-create it as a new resource. If your old resource contains loaded data, it will be lost.

moved {
  from = random_id.bucket_suffix
  to   = module.gcs.random_id.bucket_suffix
}

moved {
  from = google_storage_bucket.data_lake_bucket
  to   = module.gcs.google_storage_bucket.this
}

moved {
  from = google_bigquery_dataset.dataset
  to   = module.bigquery.google_bigquery_dataset.this
}
