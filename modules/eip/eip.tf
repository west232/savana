resource "aws_eip" "nat" {
  for_each = var.m_eip
  tags     = try(each.value.tags, {})

}