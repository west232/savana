####################################### OUTPUTS
output "eip_id" {
  value = values(aws_eip.nat)[*].id
}