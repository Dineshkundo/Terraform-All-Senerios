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

# module "Bastion-host" {
#   source = "../Bastion-host"
# }

# module "vm" {
#   source = "../vm"
#   instance_name = "my-instance"
#   machine_type  = lookup(var.machine_type, terraform.workspace, "n1-standard-1")
#   zone          = "us-central1-a"
#   tags          = ["http-server", "https-server"]
#   image         = "projects/debian-cloud/global/images/debian-12-bookworm-v20240312"
#   network       = "default"
# }




module "multiple-vm" {
  source = "../multiple-vm"
}