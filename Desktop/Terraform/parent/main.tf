provider "google" {
  project = var.project_id
  region  = var.region
}


# module "instance_template" {
#   source = "../instance_template"
# }
# module "instance-group-mig" {
#   source = "../instance-group-mig"
# }

module "Bastion-host" {
  source = "../Bastion-host"
}