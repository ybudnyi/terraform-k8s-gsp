output "cluster_namesub_ip_range" {
    value = google_compute_subnetwork.kubsub.secondary_ip_range.0.range_name  
}

output "service_namesub_ip_range" {
    value = google_compute_subnetwork.kubsub.secondary_ip_range.1.range_name  
}

output "network" {
  value = google_compute_network.kubernetes.id
}

output "subnetwork" {
  value = google_compute_subnetwork.kubsub.id
}