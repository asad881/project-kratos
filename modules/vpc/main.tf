data "aws_availability_zones" "available" {
  state = "available"
  
}

resource "aws_vpc" "ProjectKratosVPC" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(var.project_tags, {
    Name = "Project_Kratos_vpc"
  })
  
}

resource "aws_internet_gateway" "ProjectKratosIGW" {
  vpc_id = aws_vpc.ProjectKratosVPC.id

  tags = merge(var.project_tags, {
    Name = "Project_Kratos_igw"
  })
  
  
}

resource "aws_eip" "ProjectKratosEIP" {
  domain = "vpc"

  tags = merge(var.project_tags, {
    Name = "Project_Kratos_eip"
  })
  
}

resource "aws_nat_gateway" "ProjectKratosNATGateway" {
  allocation_id = aws_eip.ProjectKratosEIP.id
  subnet_id = aws_subnet.ProjectKratosPublicSubnet[0].id

  tags = merge(var.project_tags, {
    Name = "Project_Kratos_nat_gateway"
  })
}

resource "aws_subnet" "ProjectKratosPublicSubnet" {
  count = 2
  vpc_id     = aws_vpc.ProjectKratosVPC.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

}

resource "aws_subnet" "ProjectKratosPrivateSubnet" {
  count = 2
  vpc_id     = aws_vpc.ProjectKratosVPC.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

}

resource "aws_route_table" "ProjectKratosPublicRouteTable" {
  vpc_id = aws_vpc.ProjectKratosVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ProjectKratosIGW.id
  }

  tags = merge(var.project_tags, {
    Name = "Project_Kratos_public_route_table"
  })
  
}

resource "aws_route_table" "ProjectKratosPrivateRouteTable" {
  vpc_id = aws_vpc.ProjectKratosVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ProjectKratosNATGateway.id
  }

  tags = merge(var.project_tags, {
    Name = "Project_Kratos_private_route_table"
  })
  
}

resource "aws_route_table_association" "ProjectKratosPublicRouteTableAssociation" {
  count = 2
  subnet_id = aws_subnet.ProjectKratosPublicSubnet[count.index].id
  route_table_id = aws_route_table.ProjectKratosPublicRouteTable.id
}

resource "aws_route_table_association" "ProjectKratosPrivateRouteTableAssociation" {
  count = 2
  subnet_id = aws_subnet.ProjectKratosPrivateSubnet[count.index].id
  route_table_id = aws_route_table.ProjectKratosPrivateRouteTable.id
}