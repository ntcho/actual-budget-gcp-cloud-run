variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "project_name" {
  description = "A unique name for the project"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
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

variable "image_tag" {
  description = "The image tag (latest, edge, etc)"
  type        = string
  default     = "latest"
}
