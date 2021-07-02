variable "vpc_cidr" {}
variable "aws_region" {}
variable "application_name" {}
variable "environment" {}
variable "subnet_main" {}

variable "subnet_cidr_public" {}
variable "subnet_cidr_private" {}
variable "subnet_azs_public" {}
variable "subnet_azs_private" {}
variable "subnet_tier_public" {}
variable "subnet_tier_private" {}

variable "vpc_main" {}
variable "ec2_names" {}
variable "ami_id" {}
variable "key_name" {}
variable "ec2_monitoring" {}
variable "ec2_disable_api_termination" {}
variable "instance_type" {}

variable "country" {}
variable "alb_tg" {}


variable "policy_list" {}

  variable "asg_desired_capacity" {}
  variable  "asg_max_size" {}
  variable   "asg_min_size" {}
