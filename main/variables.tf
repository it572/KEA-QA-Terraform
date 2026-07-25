variable "aws_region" {
  description = "AWS regios to deploy into "
  type = string
  default = "eu-west-1"
}

variable "project_name" {
  description =  "Name prefix used for tagging and naming all resources"
  type = string
  default = "kea-qa"
}

variable "vpc_cidr" {
  description = "CIDR block for the QA VPC"
  type = string
  default =  "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type = string
  default = "10.20.1.0/24"
}

variable "availability_zone" {
  description = "AWS availanility zone for the subnet"
  type = string 
  default = "eu-west-1a"
}

variable "app_ports" {
  description = "Application ports to expose publicily"
  type = list(number)
  default = [3000,  3001]
}

variable "instance_type" {
  description = "EC2 instance type for the QA server"
  type = string
  default = "t3.medium"
}

variable "root_volume_size_gb" {
  description = "Root EBS volume size in GB"
  type = number 
  default = 30
}
