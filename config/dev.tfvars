vpc_cidr =  "10.1.0.0/16"
aws_region = "ap-southeast-1" 
application_name = "unicloud"
environment = "dev"
country = "singapore"

##public subnet details

subnet_cidr_public =  ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]

subnet_tier_public = ["web","web","web"]

subnet_azs_public = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

##private subnet details

subnet_cidr_private =  ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24", 
                  "10.1.7.0/24","10.1.8.0/24","10.1.9.0/24", 
                  "10.1.10.0/24","10.1.11.0/24","10.1.12.0/24"]

subnet_tier_private = ["app", "app", "app", 
                  "db","db","db", 
                  "ep","ep","ep"]

subnet_azs_private = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c", 
                  "ap-southeast-1a","ap-southeast-1b","ap-southeast-1c", 
                  "ap-southeast-1b","ap-southeast-1a","ap-southeast-1c"]


ec2_names = "cloudagonostic"
ami_id = "ami-018c1c51c7a13e363"
key_name = "clouddmz"
ec2_monitoring = "false"
ec2_disable_api_termination = "false"
instance_type = "t2.micro"
asg_desired_capacity = "1"
asg_max_size = "3"
asg_min_size = "1"

policy_list = ["AmazonSSMManagedInstanceCore", "CloudWatchAgentServerPolicy"]

#rds_password = "YAWGEKUEDHUuuwye73649##$tegajma"
rds_instance_class = "db.r5.xlarge"
rds_cluster_instance_identifier = "rds-clouddev-instance"
rds_cluster_identifier = "rds-clouddev-cluster"
rds_username = "sit_master_user"
rds_engine = "aurora-postgresql"
rds_engine_version = "10.7"
rds_db_name = "unicloudstackdev"
hostname = "rds-unicloudstackdev"
