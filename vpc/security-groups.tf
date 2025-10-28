#####################################
# 1. Public Security Group
#####################################
# Bu SG public subnetdəki resurslar üçündür (məsələn: bastion və ya frontend server).
# İnternetdən SSH və HTTP/HTTPS qəbul edə bilər.
resource "aws_security_group" "public_sg" {
  name        = "${var.project}-public-sg"
  description = "Allow SSH, HTTP, and HTTPS from anywhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # hər yerdən SSH üçün açıq (bastion üçün normaldır)
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
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
  }
}

#####################################
# 2. Private Security Group
#####################################
# Bu SG private subnetdəki resurslar üçündür (məsələn: backend server və ya database).
# Yalnız VPC daxilindən (yəni public SG-dən) gələn trafiki qəbul edəcək.
resource "aws_security_group" "private_sg" {
  name        = "${var.project}-private-sg"
  description = "Allow inbound traffic only from Public SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow traffic from Public SG"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
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
  }
}
