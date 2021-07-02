variable "vpc_cidr" {}
variable "aws_region" {}
variable "application_name" {}
variable "environment" {}
variable "country" {}
variable "subnet_cidr_public" {}
variable "subnet_cidr_private" {}
variable "subnet_azs_public" {}
variable "subnet_azs_private" {}
variable "subnet_tier_public" {}
variable "subnet_tier_private" {}

variable "vpc_id" {
  
}
variable "rds_subnets"{}
variable "rds_engine"{}
variable "rds_engine_version"{}
variable "rds_db_name"{}
variable "rds_username"{}
variable "rds_password"{}
variable "rds_cluster_identifier"{}
variable "hostname"{}
variable "rds_instance_class"{}
variable "rds_cluster_instance_identifier"{}
