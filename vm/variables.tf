variable "instance_name" {
  description = "Name of the instance"
}

variable "machine_type" {
  description = "Machine type for the instance"
  type = map(string)
  default = {
  dev  = "n1-standard-1"
  stage = "n1-standard-2"
  prod  = "n1-standard-4"
  }
}

variable "zone" {
  description = "Zone for the instance"
  
}

variable "tags" {
  description = "Tags for the instance"
}

variable "image" {
  description = "Image for the instance"
}

variable "network" {
  description = "Network for the instance"
}
