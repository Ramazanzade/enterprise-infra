# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  vpc = true  # deprecated, amma işləyir, əvəzinə domain istifadə edə bilərsən
  tags = {
    Name = "${var.project}-nat-eip"
  }
}

# NAT Gateway (private subnet-lər üçün)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  # 1-ci public subnet
  tags = {
    Name = "${var.project}-nat"
  }
}
