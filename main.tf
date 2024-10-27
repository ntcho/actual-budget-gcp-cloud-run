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
      subnet_region        = var.region
      subnet_private_access = true
    }
  ]
}

# Cloud Run service using v2 module
module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google//modules/v2"
  version = "~> 0.13.0"

  project_id    = var.project_id
  location      = var.region
  service_name  = "actual-server"

  containers = [
    {
      container_image = "actualbudget/actual-server:latest"
    }
  ]

  vpc_access = {
    egress = "all-traffic"
    network_interfaces = {
      network = module.vpc.network_name
      subnetwork = module.vpc.subnets_names[0]
    }
  }

  volumes = {
    gcs = {
      bucket = var.gcs_bucket_name
    }
  }
}

module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 8.0"
  project_id  = var.project_id
  names = [var.gcs_bucket_name]
}
