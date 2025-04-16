
# Provider GCP
provider "google" {
    credentials = file(var.credentials) 
    project     = var.project_id
    region      = var.region
}


# Bucket dataset
resource "google_storage_bucket" "raw-bike-trips-bucket" {
    name          = var.gcs_bucket_name
    location      = var.region
    storage_class = var.gcs_storage_class
    force_destroy = true
    uniform_bucket_level_access = true
    versioning {
        enabled = true
    }
}


# Big query
resource "google_bigquery_dataset" "bike-trips-dataset" {
    dataset_id = var.bigquery_dataset_id
    project    = var.project_id 
    location   = var.region
    delete_contents_on_destroy = true

    labels = {
        environment = "dev"
    }
    description = "Dataset de BigQuery para mi proyecto de Data Engineering"
}
