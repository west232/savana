####################################### OUTPUTS
output "sg_arn" {
  depends_on = [aws_security_group.security_group]
  value      = values(aws_security_group.security_group)[*].arn
}
output "seg_id" {
  depends_on = [aws_security_group.security_group]
  value      = values(aws_security_group.security_group)[*].id
}

output "security_ids" {
  depends_on = [aws_security_group.security_group]
  value = {
    for i in keys(aws_security_group.security_group) :
    i => aws_security_group.security_group[i].id
  }
}