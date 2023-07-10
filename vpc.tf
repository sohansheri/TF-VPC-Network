resource "aws_vpc" "lab_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.cidr_public

  tags = {
    Name = "public_subnet"
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.cidr_private
  availability_zone = "eu-west-1b"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_internet_gateway" "lab_igw" {
    vpc_id = aws_vpc.lab_vpc.id

    tags = {
        Name = "LabVpc internet gateway"
    }

}

resource "aws_subnet" "data" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.cidr_data
  availability_zone = "eu-west-1c"
  
  tags = {
    Name = "data_subnet"
  }
}

resource "aws_eip" "elastic_ip" {
    vpc = true

    tags = {
        Name = "lab elastic IP"
    }
}


resource "aws_nat_gateway" "lab_natgw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.lab_igw]
}
