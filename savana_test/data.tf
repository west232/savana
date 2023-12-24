data "aws_vpc" "pub_savana" {
  tags = {
    Name = "savana_vpc"
  }
  depends_on = [module.vpcs]
}

data "aws_subnet" "pub_savana" {
  tags = {
    Name = "pub_savana_01"
  }
  depends_on = [module.subnets]
}
data "aws_subnet" "priv_savana" {
  tags = {
    Name = "priv_savana_01"
  }
  depends_on = [module.subnets]
}
