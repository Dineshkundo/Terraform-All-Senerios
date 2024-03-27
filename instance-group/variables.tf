variable "vpc_name" {
  description = "Name for the VPC"
  default     = "my-vpc-dk"
}

variable "subnet_name" {
  description = "Name for the subnet"
  default     = "my-subnet"
}

variable "subnet_cidr_range" {
  description = "CIDR range for the subnet"
  default     = "10.0.0.0/24"
}

variable "instance_template_name" {
  description = "Name for the instance template"
  default     = "my-instance-template"
}

variable "machine_type" {
  description = "Machine type for the instance"
  type        = string
  default     = "n1-standard-1"  # Default machine type
}

variable "source_image" {
  description = "Source image for the instance"
  default     = "projects/debian-cloud/global/images/debian-12-bookworm-v20240312"
}
