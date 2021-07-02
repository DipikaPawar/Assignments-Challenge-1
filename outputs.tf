output "alb_e_dns" {value = module.elb_module.alb_e_dns}
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = "${module.database.rds_endpoint}"
}
