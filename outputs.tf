output "service_uri" {
  value       = module.cloud_run.service_uri
  description = "The URL for the Cloud Run service. Connecting here will incur small costs if you live outside North America."
}

output "firebase_hosting_url" {
  value       = google_firebase_hosting_site.default.default_url
  description = "The URL for the Firebase Hosting site. This URL has a request timeout of 60 seconds. Use the Cloud Run URL in rare cases where you need to bypass the timeout."
}
