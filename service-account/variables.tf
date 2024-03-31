variable "project_id" {
description = "My-project-id"
type = string
default = "dinesh13"
}

variable "service-acc-id" {
description = "Service Account ID for the project"
type = string
default = "ex-account"
}

variable "roles" {
  default = [
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/iam.serviceAccountUser",
    "roles/compute.instanceAdmin"
  ]
}