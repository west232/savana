################################ OUTPUTS
output "vpc_id" {
  depends_on = [aws_vpc.vpc]
  value = values(aws_vpc.vpc)[*].id
}

output "ids-vpc" {
  value = {
    for group in keys(aws_vpc.vpc) :
    group => aws_vpc.vpc[group].id
  }
}
