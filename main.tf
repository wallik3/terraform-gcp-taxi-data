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
  project     = local.env.project
  region      = "us-central1"
  credentials = var.credentials
}

module "gcs" {
  source = "./modules/gcs"

  # !Pass as a variable for modules/gcs/main.tf
  bucket_name_prefix = local.env.bucket_name_prefix
  location           = var.location
  force_destroy      = local.env.force_destroy
}

module "bigquery" {
  source = "./modules/bigquery"

  dataset_id                 = local.env.dataset_id
  location                   = var.location
  description                = "Dataset for NYC taxi trip data"
  default_expiration_days    = local.env.default_expiration_days
  delete_contents_on_destroy = local.env.delete_contents_on_destroy

  labels = {
    environment = terraform.workspace
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
