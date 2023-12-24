####################################### RESOURCES
resource "aws_nat_gateway" "nat_gateway" {
  for_each          = var.m_nat_gateway
  allocation_id     = each.value.allocation_id
  subnet_id         = each.value.subnet_id
  connectivity_type = try(each.value.connectivity_type, null)
  private_ip        = try(each.value.private_ip, null)
  secondary_allocation_ids           = try(each.value.secondary_allocation_ids, null)
  secondary_private_ip_address_count = try(each.value.secondary_private_ip_address_count, null)
  secondary_private_ip_addresses     = try(each.value.secondary_private_ip_addresses, null)
  tags = try(each.value.tags, {})
}
