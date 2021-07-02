  
variable "vpc_cidr" {
  description = "The cidr range for vpc"
  type        = string
}

variable "public_subnet_b" {
  description = "The public subnet b id"
  type        = string
}

variable "public_subnet_c" {
  description = "The public subnet c id"
  type        = string
}

variable "private_subnet_b" {
  description = "The private subnet b id"
  type        = string
}

variable "private_subnet_c" {
  description = "The private subnet c id"
  type        = string
}

variable "public_sg" {
  description = "The public security group id"
  type        = string
}

variable "private_sg" {
  description = "The private security group id"
  type        = string
}

variable "aws_region" {}
variable "application_name" {}
variable "environment" {}
variable "country" {}
variable "vpc_id" {}
variable "alb-e-subnet" {}
