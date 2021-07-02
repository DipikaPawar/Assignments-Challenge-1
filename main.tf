## local state file

 terraform {
   backend "local" {
     path    = "terraform.tfstate"
   }
 }

## state file on s3

# terraform {
#   backend "s3" {
#     bucket = "sample-bucket-name"
#     key    = "common-services/terraform.tfstate"
#     region = "ap-southeast-1"
#     encrypt = true
# 
#   }
# }

provider "aws" {
  region = var.aws_region
}

module "vpc_module" {
  source     = "../00_modules/01_vpc"

  vpc_cidr =  var.vpc_cidr
  aws_region = var.aws_region
  application_name = var.application_name
  environment = var.environment
  subnet_cidr_private = var.subnet_cidr_private
  subnet_azs_public = var.subnet_azs_public
  subnet_tier_public = var.subnet_tier_public
  subnet_cidr_public = var.subnet_cidr_public
  subnet_azs_private = var.subnet_azs_private
  subnet_tier_private = var.subnet_tier_private
  country = var.country
}



module "elb_module" {
  source     = "../00_modules/03_alb"

  vpc_cidr =  var.vpc_cidr
  aws_region = var.aws_region
  application_name = var.application_name
  environment = var.environment
  subnet_cidr_private = var.subnet_cidr_private
  subnet_azs_public = var.subnet_azs_public
  subnet_tier_public = var.subnet_tier_public
  subnet_cidr_public = var.subnet_cidr_public
  subnet_azs_private = var.subnet_azs_private
  subnet_tier_private = var.subnet_tier_private
  country = var.country

  vpc_id = module.vpc_module.vpc_main
  alb-e-subnet = module.vpc_module.subnet_public

  
}

module "ec2_module" {
  source     = "../00_modules/02_ec2"

  vpc_cidr =  var.vpc_cidr
  aws_region = var.aws_region
  application_name = var.application_name
  environment = var.environment
  subnet_cidr_private = var.subnet_cidr_private
  subnet_azs_public = var.subnet_azs_public
  subnet_tier_public = var.subnet_tier_public
  subnet_cidr_public = var.subnet_cidr_public
  subnet_azs_private = var.subnet_azs_private
  subnet_tier_private = var.subnet_tier_private
  country = var.country

  vpc_main = module.vpc_module.vpc_main
  ami_id = var.ami_id
  ec2_monitoring = var.ec2_monitoring
  instance_type = var.instance_type
  ec2_names = var.ec2_names
  key_name = var.key_name
  ec2_disable_api_termination = var.ec2_disable_api_termination
  subnet_main = [module.vpc_module.subnet_private[0], module.vpc_module.subnet_private[1], module.vpc_module.subnet_private[2]]
  alb_tg = module.elb_module.alb_tg
  policy_list = var.policy_list

  asg_desired_capacity = var.asg_desired_capacity
  asg_max_size = var.asg_max_size
  asg_min_size = var.asg_min_size
}

module "rds_module" {
  source     = "../00_modules/04_rds"

  vpc_cidr =  var.vpc_cidr
  aws_region = var.aws_region
  application_name = var.application_name
  environment = var.environment
  subnet_cidr_private = var.subnet_cidr_private
  subnet_azs_public = var.subnet_azs_public
  subnet_tier_public = var.subnet_tier_public
  subnet_cidr_public = var.subnet_cidr_public
  subnet_azs_private = var.subnet_azs_private
  subnet_tier_private = var.subnet_tier_private
  country = var.country

  rds_password = var.rds_password
  vpc_id = module.vpc_module.vpc_main
  rds_db_name = var.rds_db_name
  rds_instance_class = var.rds_instance_class
  rds_cluster_instance_identifier = var.rds_cluster_instance_identifier
  rds_cluster_identifier = var.rds_cluster_identifier
  rds_username = var.rds_username
  rds_engine = var.rds_engine
  hostname = var.hostname
  rds_engine_version = var.rds_engine_version
  rds_subnets = [module.vpc_module.subnet_private[3], module.vpc_module.subnet_private[4], module.vpc_module.subnet_private[5]]
}
