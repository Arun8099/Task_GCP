# Configure the Google Cloud provider
provider "google" {
  project = "shining-expanse-420607"
  region  = "europe-west2"
}

# Define the GKE Cluster
resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "europe-west2-a"  # Zone for your cluster

  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # Enable Kubernetes API
  enable_kubernetes_alpha = false
  remove_default_node_pool = false
}

# Enable the auto-scaler
resource "google_container_node_pool" "primary_nodes" {
  cluster = google_container_cluster.primary.name
  location = google_container_cluster.primary.location
  name = "primary-node-pool"
  
  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = 5
  }

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
