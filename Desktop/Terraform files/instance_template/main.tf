# # provider "google" {
# #   project = var.project_id
# #   region  = var.region
# # }

  module "custom_vpc" {
    source     = "../custom_vpc"
  }

resource "google_compute_instance_template" "example" {
  name        = "example-instance-template"
  description = "Example instance template"

  machine_type = "e2-medium"

  tags = ["http-server", "https-server"]

  disk {
    source_image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240312"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = module.custom_vpc.dev_subnetwork_self_link
    #network_ip = "10.0.1.10"  # Static internal IP address for the instance
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  metadata_startup_script = "echo 'Hello, World!'"
}

output "instance_template_self_link" {
  value = google_compute_instance_template.example.self_link
}
#..........................................
#working code

# resource "google_compute_instance_template" "example" {
#   name        = "example-instance-template"
#   description = "Example instance template with custom VPC"

#   machine_type = "e2-medium"

#   tags = ["web-server", "app-server"]

#   disk {
#     source_image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240312"
#     auto_delete  = true
#     boot         = true
#   }

#   network_interface {
#     subnetwork = module.custom_vpc.dev_subnetwork_self_link
#     access_config {
#       # Include this section to give the instance an external IP address
#     }
#   }

#   metadata_startup_script = "echo 'Hello, World!'"

#   # service_account {
#   #   scopes = ["cloud-platform"]
#   # }
# }