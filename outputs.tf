/*
output "vpc_cidr" {value = module.vpc_module.vpc_cidr }
output "aws_region" {value = module.vpc_module.aws_region}
output "application_name" {value = module.vpc_module.application_name }
output "environment" {value = module.vpc_module.environment }
output "subnet_cidr_private" {  value = module.vpc_module.subnet_cidr_private}
output "subnet_cidr_public" {  value = module.vpc_module.subnet_cidr_public}
output "subnet_private" {
  value = module.vpc_module.subnet_private
}
output "subnet_public" {
  value = module.vpc_module.subnet_public
}
output "vpc_main" {
  value = module.vpc_module.vpc_main
}
output "rt_public" {value = module.vpc_module.rt_public}
output "rt_private" {value = module.vpc_module.rt_private}
*/

output "alb_e_dns" {value = module.elb_module.alb_e_dns}
