variable "credentials" {
  description = "My Credentials"
  type = string
}

variable "project_id" {
  description = "My Project ID"
  type = string
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "europe-west6"  # Pick a data center location in which your services will be located
  type = string
}

variable "gcs_bucket_name" {
  description = "Nombre del bucket de Google Cloud Storage"
  type        = string
}

variable "gcs_storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default = "STANDARD"
}


variable "force_destroy_bucket" {
  description = "Determina si el bucket puede ser destruido incluso si contiene objetos"
  type        = bool
  default     = true
}


variable "bigquery_dataset_id" {
  description = "ID del dataset en BigQuery"
  type        = string
}
