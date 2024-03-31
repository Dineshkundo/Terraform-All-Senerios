
variable "zone" {
type = string
default = "us-central1-a"
}

variable "image" {
type = string
default = "debian-cloud/debian-11"
}

variable "machine_type" {
  type    = map(string)
  default = {
    dev   = "n1-standard-1"
    stage = "n1-standard-2"
    prod  = "n1-standard-4"
  }
}