variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "private_subnet" {
  description = "The private subnet to deploy Cloud Functions"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "bucket_name" {
  description = "The GCS bucket for function source code"
  type        = string
}

variable "project_id" {
  description = "The project ID"
  type        = string
}
