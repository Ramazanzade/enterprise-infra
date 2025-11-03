variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created"
  type        = string
}

variable "project" {
  description = "Project name prefix for tagging and naming"
  type        = string
}
