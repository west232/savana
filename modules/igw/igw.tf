
####################################### RESOURCES
resource "aws_internet_gateway" "internet_gw" {
  for_each = var.m_internet_gw
  vpc_id   = each.value.vpc_id
  tags     = try(each.value.tags, {})
}
