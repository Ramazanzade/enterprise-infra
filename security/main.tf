#####################################
# 1. Public Security Group
#####################################
resource "aws_security_group" "public" {
  name        = "${var.project}-public-sg"
  description = "Allow SSH, HTTP, HTTPS access from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-public-sg"
    Tier = "public"
  }
}

#####################################
# 2. Private Security Group
#####################################
resource "aws_security_group" "private" {
  name        = "${var.project}-private-sg"
  description = "Allow internal traffic and internet via NAT"
  vpc_id      = var.vpc_id

  ingress {
    description    = "Allow traffic from public SG"
    from_port      = 0
    to_port        = 0
    protocol       = "-1"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-private-sg"
    Tier = "private"
  }
}

#####################################
# 3. Outputs
#####################################
output "public_sg_id" {
  description = "ID of the public security group"
  value       = aws_security_group.public.id
}

output "private_sg_id" {
  description = "ID of the private security group"
  value       = aws_security_group.private.id
}
