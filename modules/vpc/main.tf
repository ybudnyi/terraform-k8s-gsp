resource "google_compute_network" "kubernetes" {
  name                    = "kubnetwork"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "kubsub" {
  name          = "kubsub"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.kubernetes.id
  secondary_ip_range {
    range_name    = var.cluster_range_name
    ip_cidr_range = var.cluster_cidr
  }

  secondary_ip_range {
    range_name    = var.service_range_name
    ip_cidr_range = var.service_cidr
  }
}

resource "google_compute_router" "k8srouter" {
  name = "k8srouter"
  region = var.region
  project = var.project 
  network = google_compute_network.kubernetes.self_link
}

resource "google_compute_router_nat" "natk8s" {
  name = "natk8s"
  project = var.project
  router = google_compute_router.k8srouter.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on = [
    google_compute_subnetwork.kubsub
  ]
}