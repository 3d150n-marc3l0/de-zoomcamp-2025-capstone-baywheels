output "bucket_name" {
  value = google_storage_bucket.raw-bike-trips-bucket.name
}

output "bigquery_dataset_name" {
  value = google_bigquery_dataset.bike-trips-dataset.dataset_id
}