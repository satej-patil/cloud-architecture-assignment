variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "private_subnet" {
  description = "The private subnet to deploy Cloud SQL instances"
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
