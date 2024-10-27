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
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    }
  ]
}

# Cloud Run service using v2 module
module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google//modules/v2"
  version = "~> 0.13.0"

  project_id   = var.project_id
  location     = var.region
  service_name = "actual-server"

  max_instance_request_concurrency = 5

  containers = [
    {
      container_image = "actualbudget/actual-server:latest"
      ports = {
        name = "http1"
        container_port = 5006
      }
    }
  ]

  vpc_access = {
    egress = "ALL_TRAFFIC"
    network_interfaces = {
      network    = module.vpc.network_name
      subnetwork = module.vpc.subnets_names[0]
    }
  }

  volumes = [{
    name = "actual-server-data"
    gcs = {
      bucket = var.gcs_bucket_name
    }
  }]

  depends_on = [module.gcs_buckets]
}

module "gcs_buckets" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "~> 8.0"
  project_id = var.project_id
  names      = [var.gcs_bucket_name]
  location   = var.region
}
