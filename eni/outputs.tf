####################################### OUTPUTS
output "eni_arn" {
  depends_on = [aws_network_interface.interface]
  value      = values(aws_network_interface.interface)[*].arn
}
output "eni_id" {
  depends_on = [aws_network_interface.interface]
  value      = values(aws_network_interface.interface)[*].id
}
output "eni_ids" {
  depends_on = [aws_network_interface.interface]
  value = {
    for group in keys(aws_network_interface.interface) :
    group => aws_network_interface.interface[group].id
  }
}

