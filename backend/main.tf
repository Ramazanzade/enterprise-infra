provider "aws" {
  region = "us-east-1"
}

# S3 bucket for storing Terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = "enterprise-infra-terraform-state-nizam" # unikal olmalıdır!
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "TerraformState"
    Env  = "global"
  }
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "TerraformLocks"
  }
}
