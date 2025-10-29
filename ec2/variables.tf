variable "ami" {
  description = "Amazon Machine Image ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID"
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

variable "public_key_path" {
  description = "Path to public SSH key"
  type        = string
}
