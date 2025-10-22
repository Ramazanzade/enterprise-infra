variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "my-terraform-state-bucket-nizam" # unikal olmalıdır!
}

variable "dynamodb_table" {
  description = "Name of the DynamoDB table for Terraform state lock"
  type        = string
  default     = "terraform-locks"
}

variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
  default     = "dev"
}
