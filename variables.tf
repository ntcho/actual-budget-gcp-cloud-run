variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "cloud_run_service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "gcs_bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
}

variable "billing_account_id" {
  description = "The billing account ID"
  type        = string
}

variable "currency_code" {
  description = "The currency code"
  type        = string
}
