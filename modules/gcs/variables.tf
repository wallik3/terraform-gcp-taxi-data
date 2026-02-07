variable "bucket_name_prefix" {
  # source : main.tf
  description = "Prefix for the GCS bucket name (a random hex suffix will be appended)"
  type        = string
}

variable "location" {
  # source : main.tf
  description = "GCS bucket location"
  type        = string
}

variable "storage_class" {
  description = "Storage class for the bucket"
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "Allow deleting non-empty bucket"
  type        = bool
  default     = true
}
