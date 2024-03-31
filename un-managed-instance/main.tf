module "multiple_VM_creation" {
source = "../multiple-vm"
}

# Define the unmanaged instance group
resource "google_compute_instance_group" "example_unmanaged_group" {
  name = "example-unmanaged-group"
  zone = "us-central1-a"
  instances = [
    module.multiple_VM_creation.vm1_self_link, #called from multiple_VM_creation i.e module name and attribute vm1_self_linkmodule.multiple_VM_creation.self
    module.multiple_VM_creation.vm2_self_link,
    module.multiple_VM_creation.vm3_self_link,
  ]
}

# Define a health check for the load balancer
resource "google_compute_http_health_check" "example_health_check" {
  name               = "example-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  request_path       = "/"
}

# Define a backend service for the load balancer
resource "google_compute_backend_service" "example_backend_service" {
  name                  = "example-backend-service"
  port_name             = "http"
  protocol              = "HTTP"
  timeout_sec           = 10
  health_checks         = [google_compute_http_health_check.example_health_check.self_link]
  backend {
    group = google_compute_instance_group.example_unmanaged_group.self_link
  }
}

# Define a URL map for the load balancer
resource "google_compute_url_map" "example_url_map" {
  name            = "example-url-map"
  default_service = google_compute_backend_service.example_backend_service.self_link
}

# Define a target HTTP proxy for the load balancer
resource "google_compute_target_http_proxy" "example_target_http_proxy" {
  name    = "example-target-http-proxy"
  url_map = google_compute_url_map.example_url_map.self_link
}

# Define a global forwarding rule for the load balancer
resource "google_compute_global_forwarding_rule" "example_forwarding_rule" {
  name       = "example-forwarding-rule"
  target     = google_compute_target_http_proxy.example_target_http_proxy.self_link
  port_range = "80"
}