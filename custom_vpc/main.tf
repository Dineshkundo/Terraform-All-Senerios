resource "google_compute_network" "custom_network" {
  name                    = var.custom_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "dev" {
  name          = var.dev_subnet_name
  region        = "us-central1"
  network       = google_compute_network.custom_network.self_link
  ip_cidr_range = var.dev_subnet_cidr
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "test" {
  name          = var.test_subnet_name
  region        = "us-central1"
  network       = google_compute_network.custom_network.self_link
  ip_cidr_range = var.test_subnet_cidr
  private_ip_google_access = false
}

resource "google_compute_firewall" "web-Http-ssh" {
  name    = var.firewall_web_http_ssh_name
  network = google_compute_network.custom_network.self_link

  # Allow rules
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  allow {
    protocol = "icmp"
  }

  target_tags   = ["web-server","bastion"]  # Apply to VMs with this tag
  source_ranges = ["0.0.0.0/0"]   # Allow traffic from any source
}

resource "google_compute_firewall" "app-ssh" {
  name    = var.firewall_app_ssh_name
  network = google_compute_network.custom_network.self_link

  # Allow rules
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }

  target_tags   = ["app-server","private-server"]  # Apply to VMs with this tag
  source_ranges = ["0.0.0.0/0"]   # Allow traffic from any source
}