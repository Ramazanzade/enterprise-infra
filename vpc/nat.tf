#####################################
# 1. Elastic IP (EIP)
#####################################
# NAT Gateway internetə çıxmaq üçün bu EIP-ni istifadə edəcək.
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-nat-eip"
  }
}

#####################################
# 2. NAT Gateway
#####################################
# NAT Gateway public subnetdə yaradılmalıdır, çünki orda internet çıxışı var.
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  # Public subnet 1-də yaradılır

  tags = {
    Name = "${var.project}-nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]  # NAT IGW-dən sonra yaradılmalıdır
}

#####################################
# 3. Private Route Table
#####################################
# Private subnet-lər üçün ayrıca route table yaradılır.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"          # bütün trafik
    nat_gateway_id = aws_nat_gateway.nat.id  # NAT Gateway vasitəsilə
  }

  tags = {
    Name = "${var.project}-private-rt"
  }
}

#####################################
# 4. Private Route Table Association
#####################################
# Private subnet-ləri NAT route table ilə əlaqələndiririk.
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
