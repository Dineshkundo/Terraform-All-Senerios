module "instance_template" {
  source = "../instance_template"
}

resource "google_compute_region_instance_group_manager" "appserver" {
  name = "appserver-igm"
  base_instance_name = "app"
  region = "us-central1"
  distribution_policy_zones = ["us-central1-a", "us-central1-f"]
  target_size = 2

  version {
    name = "v1"
    instance_template = module.instance_template.instance_template_self_link
  }

  named_port {
    name = "custom"
    port = 8888
  }
}
