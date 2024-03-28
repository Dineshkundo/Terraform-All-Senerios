provider "google" {
  project = var.project_id
  region  = var.region
}

# # Create a custom VPC with 2 subnets

# resource "google_compute_network" "custom_vpc" {
#   name                    = "custom-vpc"
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "subnet1" {
#   name          = "subnet1"
#   ip_cidr_range = "10.0.1.0/24"
#   network       = google_compute_network.custom_vpc.self_link
#   region        = "us-central1"
# }

# resource "google_compute_subnetwork" "subnet2" {
#   name          = "subnet2"
#   ip_cidr_range = "10.0.2.0/24"
#   network       = google_compute_network.custom_vpc.self_link
#   region        = "us-central1"
# }

# # Create a bastion server VM
# resource "google_compute_instance" "bastion" {
#   name         = "bastion"
#   machine_type = "n1-standard-1"
#   zone         = "us-central1-a"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-10"
#     }
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.subnet1.self_link
#     access_config {
#       // Ephemeral IP
#     }
#   }

#   tags = ["bastion"]
# }

# # Set IAM roles for the Service Account
# // This step cannot be automated with Terraform, you need to manually set the roles in the GCP console

# # Create firewall rules
# resource "google_compute_firewall" "bastion_private" {
#   name    = "bastion-private"
#   network = google_compute_network.custom_vpc.self_link

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = ["bastion"]
# }

# resource "google_compute_firewall" "private_bastion" {
#   name    = "private-bastion"
#   network = google_compute_network.custom_vpc.self_link

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_tags = ["bastion"]
# }

# # Generate key for ComputeEngineDefault-SA

# // This step cannot be automated with Terraform, you need to manually generate the key in the GCP console

# # Create a private server VM
# # Create a private server VM without external IP
# resource "google_compute_instance" "private_server" {
#   name         = "private-server"
#   machine_type = "n1-standard-1"
#   zone         = "us-central1-a"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-10"
#     }
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.subnet1.self_link
#     // No access_config block for no external IP
#   }

#   tags = ["private-server"]
# }

#################################3
module "custom_vpc" {
  source = "../custom_vpc"
}

# Create a bastion server VM
resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = module.custom_vpc.test_subnetwork_self_link
    access_config {
    // Ephemeral IP
  }
  }

  tags = ["bastion"]
}

# Create a private server VM without external IP
resource "google_compute_instance" "private_server" {
  name         = "private-server"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = module.custom_vpc.dev_subnetwork_self_link
    // No access_config block for no external IP
  }

  tags = ["private-server"]
}

# Create a service account with required permissions
resource "google_service_account" "custom_sa" {
  account_id   = "custom-sa"
  display_name = "Custom Service Account"
}

resource "google_project_iam_binding" "custom_sa_roles" {
  project = var.project_id
  role    = "roles/editor"
  members = [
    "serviceAccount:${google_service_account.custom_sa.email}",
  ]
}
resource "google_project_iam_binding" "compute_admin_roles" {
  project = var.project_id
  role    = "roles/compute.admin"
  members = [
    "serviceAccount:${google_service_account.custom_sa.email}",
  ]
}

resource "google_project_iam_binding" "compute_instance_admin_roles" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin.v1"
  members = [
    "serviceAccount:${google_service_account.custom_sa.email}",
  ]
}


