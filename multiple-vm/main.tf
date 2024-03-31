module "networking" {
source = "../custom_vpc"
}

module "service-account" {
source = "../service-account"
}

resource "google_compute_instance" "vm" {
  count        = 3
  name         = "${terraform.workspace}-vm-server-${count.index + 1}"
  machine_type = lookup(var.machine_type, terraform.workspace, "n1-standard-1")
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
#   scratch_disk {
#     interface = "NVME"
#   }

  network_interface {
    network = module.networking.custom_network_self_link #custom network
    subnetwork = module.networking.dev_subnetwork_self_link

    access_config {
      // Ephemeral IP
    }
  }



  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = module.service-account.svc_email
    scopes = ["cloud-platform"]
  }

  tags = ["vm-server-${count.index + 1}"]  # Add network tags

}

output "vm1_self_link" {
  value = google_compute_instance.vm[0].self_link
}

output "vm2_self_link" {
  value = google_compute_instance.vm[1].self_link
}

output "vm3_self_link" {
  value = google_compute_instance.vm[2].self_link
}
output "current_workspace" {
  value = terraform.workspace
}
