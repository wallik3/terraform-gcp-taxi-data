variable "location" {
  description = "Location for GCS buckets and BigQuery datasets"
  type        = string
  default     = "asia-southeast3"
}

variable "credentials" {
  description = "Path to GCP service account key file"
  type        = string
  sensitive   = true
}

locals {
  env_config = {
    dev = {
      project                    = "terraform-taxi-data-dev"
      bucket_name_prefix         = "taxi-data-lake-dev"
      dataset_id                 = "taxi_dataset_dev"
      default_expiration_days    = 30
      force_destroy              = true
      delete_contents_on_destroy = true
    }
    prod = {
      project                    = "terraform-taxi-data-prod"
      bucket_name_prefix         = "taxi-data-lake-prod"
      dataset_id                 = "taxi_dataset_prod"
      default_expiration_days    = 365
      force_destroy              = false
      delete_contents_on_destroy = false
    }
  }

  env = local.env_config[terraform.workspace]
}