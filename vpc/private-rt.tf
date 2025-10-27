# Private route table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags = {
    Name = "private-rt"
  }
}

# NAT Gateway-ə default route əlavə etmək
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0" # bütün internet trafikini
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Private subnet-ləri route table-ə qoşmaq
resource "aws_route_table_association" "private_subnets" {
  for_each       = toset(var.private_subnets)
  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
