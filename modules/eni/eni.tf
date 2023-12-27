####################################### RESOURCES
resource "aws_network_interface" "interface" {
  for_each                = var.m_interface
  subnet_id               = each.value.subnet_id
  private_ips             = try(each.value.private_ips, null)
  security_groups         = try(each.value.security_groups, null)
  interface_type          = try(each.value.interface_type, null)
  ipv4_prefix_count       = try(each.value.ipv4_prefix_count, null)
  ipv4_prefixes           = try(each.value.ipv4_prefixes, null)
  private_ip_list         = try(each.value.private_ip_list, null)
  private_ip_list_enabled = try(each.value.private_ip_list_enabled, null)
  private_ips_count       = try(each.value.private_ips_count, null)
  source_dest_check       = try(each.value.source-dest_check, null)

  dynamic "attachment" {
    for_each = try(each.value.attachment, {})
    content {
      instance     = attachment.value.instance
      device_index = attachment.value.device_index
    }
  }
  tags = try(each.value.tags, {})
}