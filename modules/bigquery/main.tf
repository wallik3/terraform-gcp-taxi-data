locals {
  expiration_ms = var.default_expiration_days * 24 * 60 * 60 * 1000
}

resource "google_bigquery_dataset" "this" {
  dataset_id  = var.dataset_id
  location    = var.location
  description = var.description

  default_table_expiration_ms     = local.expiration_ms
  default_partition_expiration_ms = local.expiration_ms

  delete_contents_on_destroy = var.delete_contents_on_destroy

  labels = var.labels
}
