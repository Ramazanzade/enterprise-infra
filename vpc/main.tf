provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.environment}-vpc"
    Env  = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

# Public subnets (2 AZ)
resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  map_public_ip_on_launch = true
  availability_zone = element(var.azs, index(keys(toset(var.public_subnets_cidrs)), 0)) == "" ? null : element(var.azs, index(keys(toset(var.public_subnets_cidrs)), 0))
  tags = {
    Name = "${var.environment}-public-${each.value}"
    Tier = "public"
  }
}

# Simpler approach to ensure route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
