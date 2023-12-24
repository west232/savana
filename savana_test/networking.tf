##################################### vpc
module "vpcs" {
  source = "../vpcs"
  m_vpc  = local.vpcs

}
#################################### subnets
module "subnets" {
  source   = "../subnet"
  m_subnet = local.subnets
}

####################################### security group
module "securitygroup" {
  source           = "../securitygroup"
  m_security_group = local.security_groups
}
############################################ internet gateway
module "igw" {
  source        = "../igw"
  m_internet_gw = local.internet_gw

}

##########################################  nat gateway
module "ngw" {
  source        = "../ngw"
  m_nat_gateway = local.nat-gateway

}
################################################ elastic ip
module "eip" {
  source = "../eip"
  m_eip  = local.eip
}

############################################################ route tables
resource "aws_route_table" "pub_route" {
  vpc_id = module.vpcs.vpc_id[0]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.igw.igw_id[0]
  }
  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table" "priv_route" {
  vpc_id = module.vpcs.vpc_id[0]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.ngw.ngw_id[0]

  }
  tags = {
    Name = "rt-private"
  }
}

resource "aws_route_table_association" "public-savana" {
  subnet_id      = data.aws_subnet.pub_savana.id
  route_table_id = aws_route_table.pub_route.id

}

resource "aws_route_table_association" "priv_savana" {
  subnet_id      = data.aws_subnet.priv_savana.id
  route_table_id = aws_route_table.priv_route.id
}