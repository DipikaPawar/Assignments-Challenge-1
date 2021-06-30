output "elb_dns" {
  description = "Elastic Load Balancer DNS"
  value       = "${module.application.elb_dns}"
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = "${module.database.rds_endpoint}"
}
