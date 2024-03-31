resource "google_service_account" "example_service_account" {
  account_id   = var.service-acc-id
  display_name = var.service-acc-id
  project      = var.project_id
}

resource "google_project_iam_binding" "service_account_role_bindings" {
  count   = length(var.roles)
  project = var.project_id
  role    = var.roles[count.index]
  
  members = [
    "serviceAccount:${google_service_account.example_service_account.email}"
  ]
}

#To create a new service account with new private key
# resource "google_service_account_key" "example_service_account_key" {
#   service_account_id = google_service_account.example_service_account.email
# }

# output "svc_key" {
#   value = google_service_account_key.example_service_account_key.private_key
# }

output "svc_email" {
  value = google_service_account.example_service_account.email
}