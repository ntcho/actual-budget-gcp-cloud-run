output "service_url" {
  value       = module.cloud_run.service_url
  description = "The URL on which the deployed service is available"
}

output "vpc_network" {
  value       = module.vpc.network_name
  description = "The name of the VPC network"
}
