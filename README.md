This is an implementation of the classic three tier architecture for application hosting.  <br />
Three modules that constructs our architecture:
* network
* application
* Database

![image](https://user-images.githubusercontent.com/43720925/124229196-265ed280-db05-11eb-8a32-2c7e8bb4d583.png)

## How to deploy, prerequisites for this Assignment

Setup:
* [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
* Setup your credentials via [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html#access_key)
* Clone this project

Run commands to deploy:
* ```export env=dev (or prod)```
* ```terraform get -update=true```
* ```terraform init -backend-config=config/backend-${env}.conf -backend=true```
* ```terraform apply -var-file=config/${env}.tfvars -var password=<db password> -lock=true```

## Configuration files
There are two example configuration files in the ```config/``` folder.  Each contains inputs for the main terraform module to run.
 * dev: for development environment settings
 * uat: for uat like environment settings

## Main terraform module inputs

| Name                  | Description                                           | Type   | Default | Required |
| ------                | -------------                                         | :----: | :-----: | :-----:  |
| vpc_cidr              | Thw vpc cidr range                                    | string | -       | yes      |
| aws_region            | The AWS region for 3 tier architecture                | string | -       | yes      |
| application_name      | The cidr range for db subnet c                        | string | -       | yes      |
| environment           | Environment to be deployed                            | string | -       | yes      |
| country               | Country where architecture is deployed                | string | -       | yes      |
| subnet_cidr_private   | The cidr range for private subnet                     | string | -       | yes      |
| subnet_azs_private    | The cidr range for availability                       | string | -       | yes      |
| subnet_tier_private   | The cidr range for private subnet c                   | string | -       | yes      |
| public_subnet_b_cidr  | The cidr range for public subnet b                    | string | -       | yes      |
| public_subnet_c_cidr  | The cidr range for public subnet c                    | string | -       | yes      |
| subnet_cidr_public    | Creates a snapshot when db is deleted if set to true  | string | -       | yes      |
| subnet_azs_public     | RDS username                                          | string | -       | yes      |
| subnet_tier_public    | The cidr range for vpc                                | string | -       | yes      |
| ec2_names             | Name of the EC2 instances                             | string | -       |  yes     |

## Outputs

| Name         | Description               |
| ------       | -------------             |
| elb_dns      | Elastic Load Balancer DNS |
| rds_endpoint | RDS endpoint              |
