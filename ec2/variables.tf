variable "vpc_id" {
  description = "VPC ID where EC2 instances will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for EC2"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for EC2"
  type        = string
}

variable "public_sg_id" {
  description = "Public Security Group ID"
  type        = string
}

variable "private_sg_id" {
  description = "Private Security Group ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "project" {
  description = "Project name prefix"
  type        = string
}