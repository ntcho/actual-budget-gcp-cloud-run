output "service_uri" {
  value       = module.cloud_run.service_uri
  description = "The URL on which the deployed service is available"
}

output "vpc_network" {
  value       = module.vpc.network_name
  description = "The name of the VPC network"
}
