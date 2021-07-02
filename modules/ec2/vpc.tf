#=================================================
#Defining local Attributes
#=================================================

variable "az_map" {
  type    = map
    default = {
    "ap-southeast-1a" = "a"
    "ap-southeast-1b" = "b"
    "ap-southeast-1c" = "c"
  }
}





#=================================================
#Creating Internet Gateway
#=================================================
resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "aws-igw-${var.application_name}-${var.environment}"
    Description = "igw for ${var.application_name} ${var.environment} environment"
    Environment = var.environment
  }
}


#=================================================
#Creating NAT Gateways
#=================================================
resource "aws_eip" "nat_eips" {
    vpc      = true
  
    tags = {
    Name = "aws-eip-temp-${var.application_name}-${var.environment}"
    Description = "elastic ip for ${var.application_name} ${var.environment} environment for NAT gateways"
    Environment = var.environment

  }
}

resource "aws_nat_gateway" "nat_main" {
  allocation_id = aws_eip.nat_eips.id
  subnet_id     = aws_subnet.subnet_public[0].id
  tags = {
    Name = "aws-nat-${var.application_name}-${var.environment}"
    Description = "nat gateway for ${var.application_name} ${var.environment} environment"
    Environment = var.environment

  }
}


#=================================================
#Creating VPC
#=================================================
resource "aws_vpc" "vpc_main" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = "aws-vpc-${var.application_name}-${var.environment}"
    Description = "VPC ${var.application_name} ${var.environment}"
    Environment = var.environment
  }
}

#=================================================
#Creating subnets
#=================================================
resource "aws_subnet" "subnet_private" {
  count = length(var.subnet_cidr_private)
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = var.subnet_cidr_private[count.index]
  availability_zone = var.subnet_azs_private[count.index]

  tags = {
    Name = "aws-sub-${var.application_name}-${var.environment}-${var.az_map[var.subnet_azs_private[count.index]]}-${var.subnet_tier_private[count.index]}-private"
    Description = "private subnet for ${var.application_name} ${var.environment} in tier${var.subnet_tier_private[count.index]} in ${var.subnet_azs_private[count.index]}"
    Environment = var.environment
    Country = "var.country"
    ServerType = var.subnet_tier_private[count.index]
  }
}


resource "aws_subnet" "subnet_public" {
  count = length(var.subnet_cidr_public)
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = var.subnet_cidr_public[count.index]
  availability_zone = var.subnet_azs_public[count.index]

  tags = {
    Name = "aws-sub-${var.application_name}-${var.environment}-${var.az_map[var.subnet_azs_public[count.index]]}-${var.subnet_tier_public[count.index]}-public"
    Description = "public subnet for ${var.application_name} ${var.environment} in tier${var.subnet_tier_public[count.index]} in ${var.subnet_cidr_public[count.index]}"
    Environment = var.environment
  }
}

#=================================================
#Creating route tables
#=================================================
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    egress_only_gateway_id    = ""
    nat_gateway_id                = ""
    instance_id               = ""
    ipv6_cidr_block           = ""
    network_interface_id      = ""
    transit_gateway_id        = ""
    vpc_peering_connection_id = ""
    gateway_id = aws_internet_gateway.igw_main.id
  }
  
  tags = {
    Name = "aws-rt-${var.application_name}-${var.environment}-public"
    Description = "route table for ${var.application_name} ${var.environment} environment for public subents"
    Environment = var.environment
  }

}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block = "0.0.0.0/0"
    egress_only_gateway_id    = ""
    nat_gateway_id                = aws_nat_gateway.nat_main.id
    instance_id               = ""
    ipv6_cidr_block           = ""
    network_interface_id      = ""
    transit_gateway_id        = ""
    vpc_peering_connection_id = ""
    gateway_id = ""
  }
  
  tags = {
    Name = "aws-rt-${var.application_name}-${var.environment}-private"
    Description = "route table for ${var.application_name} ${var.environment} environment for private subents"
    Environment = var.environment
  }

}

#=================================================
#Creating route tables associations
#=================================================

resource "aws_route_table_association" "rt_associations_private" {
  count = length(var.subnet_cidr_private)
  subnet_id      = aws_subnet.subnet_private[count.index].id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_associations_public" {
  count = length(var.subnet_cidr_public)
  subnet_id      = aws_subnet.subnet_public[count.index].id
  route_table_id = aws_route_table.rt_public.id
}
