output "ngw_id" {
  value = values(aws_nat_gateway.nat_gateway)[*].id
}