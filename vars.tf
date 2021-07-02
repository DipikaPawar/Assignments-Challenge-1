variable "vpc_cidr" {}
variable "aws_region" {}
variable "application_name" {}
variable "environment" {}

variable "country" {}
variable "subnet_cidr_private" {}
variable "subnet_azs_private" {}
variable "subnet_tier_private" {}

variable "subnet_cidr_public" {}
variable "subnet_azs_public" {}
variable "subnet_tier_public" {}


variable "ec2_names" {}
variable "ami_id" {}
variable "key_name" {}
variable "ec2_monitoring" {}
variable "ec2_disable_api_termination" {}
variable "instance_type" {}

variable "policy_list" {}

  variable "asg_desired_capacity" {}
  variable  "asg_max_size" {}
  variable   "asg_min_size" {}

variable "rds_password" {}
variable "rds_instance_class" {}
variable "rds_cluster_identifier" {}
variable "rds_username"{}
variable "rds_cluster_instance_identifier" {
  
}
variable "rds_engine" {
  
}

variable "rds_engine_version" {
  
}

variable "rds_db_name" {
  
}
variable "hostname" {
  
}
