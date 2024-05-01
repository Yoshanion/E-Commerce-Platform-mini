module "vpc" {
  source      = "../../modules/vpc"
  region      = "us-west-2"
  cidr_block  = "10.0.0.0/16"
  environment = "prod"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

module "eks" {
  source              = "../../modules/eks"
  cluster_name        = "global-ecommerce-eks"
  region              = "us-east-1"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  node_group_settings = {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  } 
}

module "rds" {
  source = "../../modules/rds"
  db_instance_class = "db.t3.medium"
  db_name           = "ecommerce"
  db_username       = "admin"
  db_password       = "admin"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  db_subnet_group_name = "my-db-subnet-group"
}