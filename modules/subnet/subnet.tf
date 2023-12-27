######################################### OUTPUTS
output "subnet_id" {
  value = values(aws_subnet.subnets)[*].id
}


########################################## resource
resource "aws_subnet" "subnets" {
  for_each                                       = var.m_subnet
  vpc_id                                         = each.value.vpc_id
  cidr_block                                     = try(each.value.cidr_block, null)
  availability_zone                              = try(each.value.availability_zone, null)
  availability_zone_id                           = try(each.value.availability_zone_id, null)
  map_public_ip_on_launch                        = try(each.value.map_public_ip_on_launch, null)
  customer_owned_ipv4_pool                       = try(each.value.customer_owned_ipv4_pool, null)
  enable_dns64                                   = try(each.value.enable_dns64, null)
  enable_lni_at_device_index                     = try(each.value.enable_lni_at_device_index, null)
  enable_resource_name_dns_aaaa_record_on_launch = try(each.value.enable_resource_name_dns_aaaa_record_on_launch, null)
  enable_resource_name_dns_a_record_on_launch    = try(each.value.enable_resource_name_dns_a_record_on_launch, null)
  map_customer_owned_ip_on_launch                = try(each.value.map_customer_owned_ip_on_launch, null)
  outpost_arn                                    = try(each.value.outpost_arn, null)
  private_dns_hostname_type_on_launch            = try(each.value.private_dns_hostname_type_on_launch, null)
  tags                                           = try(each.value.tags, {})
} 