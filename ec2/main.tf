#####################################
# 1. Data — Son Amazon Linux 2 AMI-ni avtomatik tap
#####################################
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#####################################
# 2. Key Pair — SSH üçün
#####################################
resource "aws_key_pair" "main" {
  key_name   = "${var.project}-key"
  public_key = file(var.public_key_path)
}

#####################################
# 3. Public EC2 Instance
#####################################
resource "aws_instance" "public_ec2" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.project}-public-ec2"
    Tier = "public"
  }
}

#####################################
# 4. Private EC2 Instance
#####################################
resource "aws_instance" "private_ec2" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.private_sg_id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = false

  tags = {
    Name = "${var.project}-private-ec2"
    Tier = "private"
  }
}
