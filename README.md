## Challenge 1

A 3 tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility. How to deploy, prerequisites for this Assignment

This is an implementation of the classic three tier architecture for application hosting. AWS best practices are followed in this 3-tier infrastructure pattern, because it gives you multiple levels of security, scalability, high availability, and redundancy.  <br />
This should launch a basic 3-tier infrastructure following:
1.  VPC
2.  Private and public subnets
3.  An internet-facing ALB
4.  An autoscaling group of Ec2 instances in private subnets
5.  An RDS cluster in private subnets and all other resources defined in userdata.sh

![image](https://user-images.githubusercontent.com/43720925/124229196-265ed280-db05-11eb-8a32-2c7e8bb4d583.png)

## How to deploy, prerequisites for this Assignment

Setup:
* [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
* Setup your credentials via [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html#access_key)
* Clone this project

Run commands to deploy:
* ```export env=dev (or prod)```
* ```terraform get -update=true```
* ```terraform init```
* ```terraform plan```
* ```terraform apply -var-file=config/${env}.tfvars -var password=<db password>``` ## From security perspective password should be given as input value

## Configuration files
There are two example configuration files in the ```config/``` folder.  Each contains inputs for the main terraform module to run.
 * dev: for development environment settings
 * uat: for uat like environment settings




