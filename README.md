This is an implementation of the classic three tier architecture for application hosting.  <br />
Three modules that constructs our architecture:
* network
* application
* Database

![image]![image](https://user-images.githubusercontent.com/43720925/124229196-265ed280-db05-11eb-8a32-2c7e8bb4d583.png)

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
| allocated_storage     | The amount of allocated storage                       | string | -       | yes      |
| db_subnet_b_cidr      | The cidr range for db subnet b                        | string | -       | yes      |
| db_subnet_c_cidr      | The cidr range for db subnet c                        | string | -       | yes      |
| instance_class        | RDS instance class (e.g. db.t2.micro or db.m4.xlarge) | string | -       | yes      |
| multi_az              | Create a replica in different zone if set to true     | string | -       | yes      |
| password              | RDS password                                          | string | -       | yes      |
| private_subnet_b_cidr | The cidr range for private subnet b                   | string | -       | yes      |
| private_subnet_c_cidr | The cidr range for private subnet c                   | string | -       | yes      |
| public_subnet_b_cidr  | The cidr range for public subnet b                    | string | -       | yes      |
| public_subnet_c_cidr  | The cidr range for public subnet c                    | string | -       | yes      |
| skip_final_snapshot   | Creates a snapshot when db is deleted if set to true  | string | -       | yes      |
| username              | RDS username                                          | string | -       | yes      |
| vpc_cidr              | The cidr range for vpc                                | string | -       | yes      |

## Outputs

| Name         | Description               |
| ------       | -------------             |
| elb_dns      | Elastic Load Balancer DNS |
| rds_endpoint | RDS endpoint              |
