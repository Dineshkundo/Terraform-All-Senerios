output "custom_network_self_link" {
  value = google_compute_network.custom_network.self_link
}

output "dev_subnetwork_self_link" {
  value = google_compute_subnetwork.dev.self_link
}

output "test_subnetwork_self_link" {
  value = google_compute_subnetwork.test.self_link
}

output "web_http_ssh_firewall_self_link" {
  value = google_compute_firewall.web-Http-ssh.self_link
}

output "app_ssh_firewall_self_link" {
  value = google_compute_firewall.app-ssh.self_link
}

