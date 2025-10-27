terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-nizam"
    key            = "envs/dev/backend-init/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}