provider "aws" {
    region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true 

  tags = {
    command = "VPC-${var.environment}"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

#Public

resource "aws_subnet" "public" {
    count   = length(var.availability_zones)
    vpc_id  = aws_vpc.main.id
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true 
    
    tags = {
        Name = "Public-${var.environment}-${count.index}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet_access" {
   route_table_id         = aws_route_table.public.id
   destination_cidr_block = "0.0.0.0/0"
   gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
    count          = length(aws_subnet.public.*.id)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

# NAT for Public subnets

resource "aws_eip" "nat" {
    count = length(var.availability_zones)
    vpc   = true
}

resource "aws_nat_gateway" "nat" {
    count         = length(var.availability_zones)
    allocation_id = aws_eip.nat[count.index].id
    subnet_id     = aws_subnet.public[count.index].id
}

#NPrivate + NAT

resource "aws_subnet" "private" {
    count             = length(var.availability_zones)
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + 100)
    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "Private-${var.environment}-${count.index}"
     }
}

resource "aws_route_table" "private" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "nat_access" {
    count                  = length(var.availability_zones)
    route_table_id         = aws_route_table.private[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

resource "aws_route_table_association" "private" {
    count          = length(aws_subnet.private.*.id)
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}