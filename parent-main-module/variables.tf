variable "project_id" {
  type        = string
  description = "The project ID"
  default     = "dinesh13"
}

variable "region" {
  type        = string
  description = "The region for the infrastructure"
  default     = "us-central1"
}

variable "svc_id" {
description = "account-id"
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
