variable "project" {
  description = "GCP project ID"
  type        = string
}

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