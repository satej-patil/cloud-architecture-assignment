variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "asia-south1" // India region
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR range for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR range for the private subnet"
  type        = string
}
