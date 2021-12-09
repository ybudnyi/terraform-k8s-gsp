resource "google_service_account" "k8s" {
  project    = var.project
  account_id = "k8s-testing"
}

resource "google_container_cluster" "kuber" {
  name               = "k8scluster"
  location           = var.region
  remove_default_node_pool = true
  initial_node_count       = 3
  default_max_pods_per_node = 40
  networking_mode = "VPC_NATIVE"
  network    = var.compute_network
  subnetwork = var.compute_subnetwork
  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_namesub_ip_range
    services_secondary_range_name = var.service_namesub_ip_range
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_container_node_pool" "primary" {
  name       = "k8spool"
  cluster    = google_container_cluster.kuber.id
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    service_account = google_service_account.k8s.email
  }
}
