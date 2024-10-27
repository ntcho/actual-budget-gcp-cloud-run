/**
 * Sets up VPC network and Cloud Run service for actual-server
 */

# VPC Network configuration
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.3"

  project_id   = var.project_id
  network_name = "actual-network"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "actual-subnet"
      subnet_ip            = "10.10.10.0/24"
      subnet_region        = "us-central1"
      subnet_private_access = true
    }
  ]
}

# Service Account for Cloud Run
module "service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 4.2"

  project_id = var.project_id
  prefix     = "sa-actual"
  names      = ["server"]
}

# Cloud Run service
module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.13.0"

  service_name          = "actual-server"
  project_id           = var.project_id
  location             = "us-central1"
  image                = "actualbudget/actual-server:latest"
  service_account_email = module.service_account.email

  template_annotations = {
    "autoscaling.knative.dev/maxScale" = "3"
    "autoscaling.knative.dev/minScale" = "1"
    "run.googleapis.com/vpc-access-connector" = module.vpc.connector_ids["us-central1"]
  }

  env_vars = [
    {
      name  = "PORT"
      value = "3000"
    },
    {
      name  = "ACTUAL_UPLOAD_DIR" 
      value = "/data"
    }
  ]
}
