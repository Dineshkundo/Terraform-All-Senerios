
variable "custom_network_name" {
  type        = string
  description = "The name of the custom network"
  default     = "custom-vpc-terraform1"
}

variable "dev_subnet_name" {
  type        = string
  description = "The name of the dev subnet"
  default     = "dev-subnet"
}

variable "test_subnet_name" {
  type        = string
  description = "The name of the test subnet"
  default     = "test-subnet"
}

variable "dev_subnet_cidr" {
  type        = string
  description = "The CIDR range for the dev subnet"
  default     = "10.0.1.0/24"
}

variable "test_subnet_cidr" {
  type        = string
  description = "The CIDR range for the test subnet"
  default     = "10.0.2.0/24"
}

variable "firewall_web_http_ssh_name" {
  type        = string
  description = "The name of the web HTTP SSH firewall rule"
  default     = "tcp-22-80"
}

variable "firewall_app_ssh_name" {
  type        = string
  description = "The name of the app SSH firewall rule"
  default     = "tcp-22"
}

