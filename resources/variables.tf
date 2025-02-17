variable "project_name" {
  type        = string
  description = "Name of the project, used for resource naming"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}