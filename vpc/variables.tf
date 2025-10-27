variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# Public subnet CIDRs as list
variable "public_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Optional: AZ list (can be empty and be ignored)
variable "azs" {
  type    = list(string)
  default = []
}
