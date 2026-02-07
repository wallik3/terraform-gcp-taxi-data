# Purpose : To be logged after run `terraform apply`
output "gcs_bucket_name" {
  description = "The name of the GCS data lake bucket"
  value       = module.gcs.bucket_name
}

output "gcs_bucket_url" {
  description = "The gsutil URI of the data lake bucket"
  value       = module.gcs.bucket_url
}

output "bigquery_dataset_id" {
  description = "The ID of the BigQuery dataset"
  value       = module.bigquery.dataset_id
}
