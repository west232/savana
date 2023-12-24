####################################### OUTPUTS
output "gw_arn" {
  depends_on = [aws_internet_gateway.internet_gw]
  value      = values(aws_internet_gateway.internet_gw)[*].arn
}
output "igw_id" {
  value = values(aws_internet_gateway.internet_gw)[*].id 
}
