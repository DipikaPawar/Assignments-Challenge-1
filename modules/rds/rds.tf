####################################################
#RDS Subnet Group
####################################################

resource "aws_db_subnet_group" "rds-subnet-group" {
  subnet_ids = var.rds_subnets
  name = "aws-${var.application_name}-${var.environment}-db"
  description = "rds subnet group for ${var.application_name} ${var.environment} environment"
  tags = {
    Name = "aws-${var.application_name}-${var.environment}-db"
    Description = "rds subnet group for ${var.application_name} ${var.environment} environment"
    Environment = "${var.environment}"
  }
}

###################################################
#RDS Cluster
####################################################

resource "aws_rds_cluster" "cluster-rds" {
  cluster_identifier      = var.rds_cluster_identifier
  engine                  = var.rds_engine
  database_name           = var.rds_db_name
  master_username         = var.rds_username
  master_password         = var.rds_password
  engine_version = var.rds_engine_version
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.id
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  #kms_key_id = "${var.kms_key_universal}"
  storage_encrypted = true
  backup_retention_period             = 7
  deletion_protection                 = false 
  copy_tags_to_snapshot = true
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.cluster_parameter_group.id}"
  enabled_cloudwatch_logs_exports = ["postgresql"]
  tags = {
    Name = "aws-rdsauroradb-${var.application_name}-${var.environment}-${var.hostname}-prisubdb"
    Description = "rds aurora database for ${var.application_name} ${var.environment} environment"
    Environment = var.environment
    auto-start-stop = "True"
  }
}

####################################################
# RDS Cluster Instance
####################################################

resource "aws_rds_cluster_instance" "rds-instance" {
  identifier         = var.rds_cluster_instance_identifier
  engine_version = var.rds_engine_version
  engine                  = var.rds_engine
  cluster_identifier = aws_rds_cluster.cluster-rds.id
  instance_class     = var.rds_instance_class
  performance_insights_enabled = true
  copy_tags_to_snapshot               = true 
}

#============================================================
#RDS Cluter Parameter Group
#============================================================

resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  name        = "aws-cpg-emtu-prod-tf"
  family      = "aurora-postgresql10"
  description = "RDS cluster parameter group"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  parameter {
   name         = "log_min_duration_statement"
   value        = "10"
  }

  
  parameter {
   name         = "auto_explain.log_min_duration"
   value        = "10"
  }

  parameter {
    name        = "timezone"
    value       = "asia/singapore"
  }
}


#===============================
#rds 01 sg 
#================================
resource "aws_security_group" "rds-sg" {
  name = "aws-sg-${var.application_name}-${var.environment}"
  description = "RDS security group"
  vpc_id      = "${var.vpc_id}"
  tags = {
    Name = "aws-sg-${var.application_name}-${var.environment}"
    Description = "security group for rds in ${var.application_name} ${var.environment} environment"
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "rdsrule1" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = -1
  security_group_id = "${aws_security_group.rds-sg.id}"
  cidr_blocks     = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "rdsrule2" {
  type            = "ingress"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"
  security_group_id = "${aws_security_group.rds-sg.id}"
  cidr_blocks = var.subnet_cidr_private
}
