output "vpc_cidr" {value = var.vpc_cidr }
output "aws_region" {value = var.aws_region}
output "application_name" {value = var.application_name }
output "environment" {value = var.environment }
output "subnet_cidr_private" {  value = var.subnet_cidr_private}
output "subnet_cidr_public" {  value = var.subnet_cidr_public}

output "subnet_private" {
  value = aws_subnet.subnet_private.*.id
}

output "subnet_public" {
  value = aws_subnet.subnet_public.*.id
}

output "vpc_main" {
  value = aws_vpc.vpc_main.id
}

output "rt_public" {value = aws_route_table.rt_public.id}
output "rt_private" {value = aws_route_table.rt_private.id}
