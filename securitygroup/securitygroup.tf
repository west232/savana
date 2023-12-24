####################################### RESOURCES
resource "aws_security_group" "security_group" {
  for_each               = var.m_security_group
  name                   = each.value.name
  vpc_id                 = each.value.vpc_id
  description            = try(each.value.description, null)
  revoke_rules_on_delete = try(each.value.revoke_rules_on_delete, null)
  tags                   = try(each.value.tags, {})

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = try(ingress.value.cidr_blocks, null)
      security_groups = try(ingress.value.security_groups, null)
      description     = try(ingress.value.description, null)
      self            = try(ingress.value.self, null)
    }
  }
  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = try(egress.value.cidr_blocks, null)
      security_groups = try(egress.value.security_groups, null)
      description     = try(egress.value.description, null)
      self            = try(egress.value.self, null)
    }
  }

}