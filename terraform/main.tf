resource "google_cloud_run_service" "api" {
  name     = "api"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project}/gcp-cloud-run-go"
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.api.location
  service  = google_cloud_run_service.api.name
  role     = "roles/run.invoker"
  member   = "allUsers"

  lifecycle {
    replace_triggered_by = [
      google_cloud_run_service.api
    ]
  }
}

output "uri" {
  value = google_cloud_run_service.api.status[0].url
}