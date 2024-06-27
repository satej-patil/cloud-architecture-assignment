variable "bucket_name" {
  description = "The GCS bucket for CDN"
  type        = string
}

variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}
