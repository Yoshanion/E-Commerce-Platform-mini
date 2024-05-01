variable "db_instance_class" {
    description = "The instance type of the RDS instance"
    type = string
}

variable "db_name" {
    description = "The name of the database"
    type = string
}

variable "db_username" {
    description = "Username for database"
    type = string
}

variable "db_password" {
    description = "Password for the database"
    type = string
    sensitive = true
}

variable "vpc_security_group_ids" {
    description = "List of VPC security group IDs to associate"
    type = list(string)
}

variable "db_subnet_group_name" {
    description = "DB subnet group name"
    type = string
}

variable "db_instance_class" {
    description = "Specifies if the RDS instance is multi-AZ"
    type = bool
    default = true
}