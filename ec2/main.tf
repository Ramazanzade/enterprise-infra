#####################################
# 1. Key Pair
#####################################
resource "aws_key_pair" "main" {
  key_name   = "${var.project}-key"
  public_key = file(var.public_key_path)  # ⚡ artıq tam path istifadə olunur
}

#####################################
# 2. Public EC2 Instance
#####################################
resource "aws_instance" "public_ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = aws_key_pair.main.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.project}-public-ec2"
    Tier = "public"
  }
}

#####################################
# 3. Private EC2 Instance
#####################################
resource "aws_instance" "private_ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = aws_key_pair.main.key_name
  associate_public_ip_address = false

  tags = {
    Name = "${var.project}-private-ec2"
    Tier = "private"
  }
}
