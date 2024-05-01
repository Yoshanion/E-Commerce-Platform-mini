resource "aws_db_instance" "default" {
    identifier = "econnerce-db"
    engine     = "mysql"
    engine_version  = "8.0"
    instance_class  = var.db_instance_class
    allocated_storage = 20
    storage_type = "gp2"
    db_name      = var.db_name
    username     = var.db_username
    password     = var.db_password
    vpc_security_group_ids = var.vpc_security_group_ids
    db_subnet_group_name = var.db_subnet_group_name
    multi_az             = var.multi_az
    publicly_accessible  = false

    tags = {
        Enviroment = "production"
    }

}

resource "aws_db_subnet_group" "default" {
    name = var.db_subnet_group_name
    subnet_ids = var.vpc_security_group_ids

    tag = {
        Name = "My DB subnet group"
    }
}