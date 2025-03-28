provider "google" {
  credentials = file("C:/Users/kumar/Downloads/cool-ocean-449307-h8-16bfe58bfd2d.json")  # Path to your GCP service account key
  project     = "cool-ocean-449307-h8"  # GCP Project ID
  region      = "us-central1"  # Region where resources will be created
}

# Create a Google Cloud Run service
resource "google_cloud_run_service" "api_service" {
  name     = "rest-api-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "<your_docker_image_url>"  # Docker image URL (e.g., from Google Container Registry)
      }
    }
  }
}

# Create a project IAM member to allow all users to invoke the Cloud Run service
resource "google_project_iam_member" "cloud_run_invoker" {
  project = "<your_project_id>"
  role    = "roles/run.invoker"
  member  = "allUsers"
}

# Output the Cloud Run service URL
output "cloud_run_url" {
  value = google_cloud_run_service.api_service.status[0].url
}
