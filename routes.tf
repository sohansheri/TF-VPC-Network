resource "aws_route_table" "internet_routetbl" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }

  tags = {
    Name = "int-route-table"
  }
}

resource "aws_route_table" "nat_routetbl" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lab_natgw.id
  }

  tags = {
    Name = "nat-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.internet_routetbl.id
}

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.nat_routetbl.id
# }

# resource "aws_route_table_association" "data" {
#   subnet_id      = aws_subnet.data.id
#   route_table_id = aws_route_table.nat_routetbl.id
# }