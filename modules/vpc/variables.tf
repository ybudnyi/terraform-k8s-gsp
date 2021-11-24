variable "project" {
  default = "k8ssoftserve-327607"
}
variable "region" {
  default = "us-central1"
}

variable "cluster_cidr" {
    default = "192.168.0.0/20"
}

variable "service_cidr" {
  default = "192.168.16.0/20"
}

variable "cluster_range_name" {
  default = "services-range"
}

variable "service_range_name" {
  default = "pod-ranges"
}
