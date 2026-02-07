# 4 Main Building Blocks in TF : 
# 1. Terraform - TF Setting
# 2. Provider - Cloud Provider level setting
# 3. Resource - Provider Service level setting
# 4. Variables/Locals - UserInput/Constant

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
  credentials = var.credentials # Other best practice : set env (eg. export GOOGLE_CREDENTIALS='credentials/cred.json')& run terraform
}

# GCS Bucket name must be globally unique. thus, random-uuid is used
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Resource Block Anatomy
# resource <TYPE:cloud-provider-type> <NAME:custom name for tf reference>
resource "google_storage_bucket" "data_lake_bucket" {
  # GCS Bucket name must be globally unique
  name          = "taxi-data-lake-${random_id.bucket_suffix.hex}" # → e.g. taxi-data-lake-a3b1c9f2
  location      = var.location

  # Optional, but recommended settings:
  storage_class = "STANDARD" # Lit[STANDARD, NEARLINE, COLDLINE, ARCHIVE]
  uniform_bucket_level_access = true

  # This is called sub-block attribute
  # Keeps previous versions of objects when overwritten or deleted.
  versioning {
    enabled = true
  }

  # Do this if the object have age exceeds condition
  # Days 0–9: Object stays in STANDARD (frequent access)
  # Days 10–29: Object transitions to NEARLINE (infrequent access, cheaper)
  # Day 30+: Object is deleted
  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 10  // days
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  # Allow delete non-empty bucket 
  force_destroy = true
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = "taxi_dataset"
  location   = var.location
  description = "Dataset for NYC taxi trip data"

  # Auto-delete tables 90 days after creation (optional, good for staging/temp data)
  # Note : If you ingested from gcs, the source data in gcs is not deleted.
  default_table_expiration_ms = local.default_expiration_ms

  # Auto-delete each partition 90 days after its partition date
  default_partition_expiration_ms = local.default_expiration_ms

  # Prevent accidental deletion if dataset contains tables
  delete_contents_on_destroy = false

  # Labels for cost tracking and organization
  labels = {
    environment = "dev"
    project     = "taxi-data"
  }
}