resource "google_firebase_hosting_site" "default" {
  provider = google-beta
  project  = data.google_project.default.project_id
  site_id  = var.project_name

  depends_on = [
    google_project_service.default
  ]
}

resource "google_firebase_hosting_version" "default" {
  provider = google-beta
  site_id  = google_firebase_hosting_site.default.site_id
  config {
    rewrites {
      glob = "/**"
      run {
        region     = var.region
        service_id = module.cloud_run.service_name
      }
    }
  }
}

resource "google_firebase_hosting_release" "default" {
  provider     = google-beta
  site_id      = google_firebase_hosting_site.default.site_id
  version_name = google_firebase_hosting_version.default.name
  message      = "Deployed by Terraform"
}