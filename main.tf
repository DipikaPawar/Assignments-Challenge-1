# ------------------------------------------------------------------------------
# CONFIGURING 3 TIER ARCHITECTURE
# ------------------------------------------------------------------------------

provider "aws" {
  region = "ap-southeast-2"
}

#terraform {
#backend "s3" {}
#}

# ------------------------------------------------------------------------------
# RUNNING MODULES
# ------------------------------------------------------------------------------

module "network" {
  source                = "./modules/network"
  vpc_cidr              = "${var.vpc_cidr}"
  public_subnet_b_cidr  = "${var.public_subnet_b_cidr}"
  public_subnet_c_cidr  = "${var.public_subnet_c_cidr}"
  private_subnet_b_cidr = "${var.private_subnet_b_cidr}"
  private_subnet_c_cidr = "${var.private_subnet_c_cidr}"
  db_subnet_b_cidr      = "${var.db_subnet_b_cidr}"
  db_subnet_c_cidr      = "${var.db_subnet_c_cidr}"
}

module "application" {
  source           = "./modules/application"
  vpc_cidr         = "${var.vpc_cidr}"
  aws_region = var.aws_region
  application_name = var.application_name
  environment = var.environment
  public_subnet_b  = "${module.network.public_subnet_b}"
  public_subnet_c  = "${module.network.public_subnet_c}"
  private_subnet_b = "${module.network.private_subnet_b}"
  private_subnet_c = "${module.network.private_subnet_c}"
  public_sg        = "${module.network.public_sg}"
  private_sg       = "${module.network.private_sg}"
  country = var.country

  vpc_id = module.vpc_module.vpc_main
  alb-e-subnet = module.vpc_module.subnet_public
}

module "database" {
  source              = "./modules/database"
  db_subnet_b         = "${module.network.db_subnet_b}"
  db_subnet_c         = "${module.network.db_subnet_c}"
  db_security_group   = "${module.network.private_sg}"
  username            = "${var.username}"
  password            = "${var.password}"
  instance_class      = "${var.instance_class}"
  multi_az            = "${var.multi_az}"
  allocated_storage   = "${var.allocated_storage}"
  skip_final_snapshot = "${var.skip_final_snapshot}"
}
