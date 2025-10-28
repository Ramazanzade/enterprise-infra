variable "project" {
  description = "Project name prefix"
  type        = string
  default     = "enterprise"
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}
