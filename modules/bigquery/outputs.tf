output "dataset_id" {
  description = "The ID of the BigQuery dataset"
  value       = google_bigquery_dataset.this.dataset_id
}

output "dataset_self_link" {
  description = "The self_link of the dataset"
  value       = google_bigquery_dataset.this.self_link
}

output "project" {
  description = "The project in which the dataset was created"
  value       = google_bigquery_dataset.this.project
}
