variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-2"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-2 = "ami-82f4dae7" # ubuntu 16.04 LTS
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}
variable "public_subnet2_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.2.0/24"
}

variable "private_subnet1_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "private_subnet2_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.3.0/24"
}

