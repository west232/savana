#############################################  Resources
resource "aws_vpc" "vpc" {
  for_each                             = var.m_vpc
  cidr_block                           = each.value.cidr_block
  instance_tenancy                     = try(each.value.instance_tenancy, null)
  ipv4_ipam_pool_id                    = try(each.value.ipv4_ipam_pool_id, null)
  ipv4_netmask_length                  = try(each.value.ipv4_netmask_length, null)
  enable_dns_support                   = try(each.value.enable_dns_support, null)
  enable_network_address_usage_metrics = try(each.value.enable_network_address_usage_metrics, null)
  enable_dns_hostnames                 = try(each.value.enable_dns_hostnames, null)
  tags                                 = try(each.value.tags, null)
}
