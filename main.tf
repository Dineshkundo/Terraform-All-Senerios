provider "google" {
  project = local.project_id
  region  = local.region
}

locals {
  project_id = "dinesh13"
  region     = "us-central1"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.31.0"
    }
  }

  required_version = "~> 1.0"
}


resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr_range
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_instance_template" "instance_template" {
  name        = var.instance_template_name
  machine_type = var.machine_type
  disk {
    source_image = var.source_image
    auto_delete  = true
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      // Ephemeral IP
    }
  }
}

output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "instance_template_id" {
  value = google_compute_instance_template.instance_template.id
}
