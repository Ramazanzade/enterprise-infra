# Elastic IP (NAT Gateway üçün)
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway yaratmaq (Public subnet-də)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(var.public_subnets, 0) # 1-ci public subnet-i istifadə edirik
  tags = {
    Name = "nat-gateway"
  }
}
