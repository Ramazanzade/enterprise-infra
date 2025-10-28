variable "project" {
  description = "Project name prefix"
  type        = string
  default     = "enterprise"
}

variable "ami" {
  description = "Amazon Machine Image (AMI) ID"
  type        = string
  default     = "ami-0c7217cdde317cfec" # Amazon Linux 2023 (Frankfurt)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Path to SSH public key (tam path göstərilməlidir)"
  type        = string
  default     = "/home/broops/.ssh/id_rsa.pub"  # 🔑 tam path
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
