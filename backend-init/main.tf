provider "aws" {
  region = var.aws_region
}

# S3 bucket (Terraform state üçün)
resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name

  tags = {
    Name        = "terraform-state-bucket"
    Environment = var.environment
  }
}

# Versioning açmaq (state faylını qorumaq üçün)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption (security best practice)
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# DynamoDB table (lock üçün)
resource "aws_dynamodb_table" "tf_lock" {
  name         = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-lock-table"
    Environment = var.environment
  }
}
