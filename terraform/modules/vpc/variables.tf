variable "region" {
  description = "The AWS region to create the VPC."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., prod, staging)."
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones in which to create subnets."
  type        = list(string)
}