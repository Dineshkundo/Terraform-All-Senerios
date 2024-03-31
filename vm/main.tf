resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = lookup(var.machine_type, terraform.workspace, "n1-standard-1")
  zone         = var.zone
  tags         = var.tags
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = var.network
    access_config {
      // Ephemeral IP
    }
  }
  

  service_account {
    email  = "49115291185-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", 
              "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", 
              "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", 
              "https://www.googleapis.com/auth/trace.append"]
  }

}


