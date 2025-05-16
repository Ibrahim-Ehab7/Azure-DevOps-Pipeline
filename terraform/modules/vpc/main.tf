resource "aws_vpc" "main" {
  cidr_block           =  var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "CICD"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block =  var.private_subnet_cidr[count.index]
  availability_zone = var.Availability_Zones[count.index]

  tags = {
    Name = "${var.cluster_name}-private-${count.index +1}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.Availability_Zones[count.index]

  tags = {
    Name = "${var.cluster_name}-public-${count.index +1}"
    "kubernetes.io/role/elb"= "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}


resource "aws_internet_gateway" "GW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.cluster_name}-IGW"
  }
}

resource "aws_route_table" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GW.id
  }

  tags = {
    Name = "${var.cluster_name}-public-route-table-${count.index +1}"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}


resource "aws_eip" "nat" {
  count    = length(var.public_subnet_cidr)
  domain   = "vpc"
}

resource "aws_nat_gateway" "main" {
  count = length(var.public_subnet_cidr)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.cluster_name}-NAT-GW-${count.index +1}"
  }
}


resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "${var.cluster_name}-private-route-table-${count.index +1}"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}


