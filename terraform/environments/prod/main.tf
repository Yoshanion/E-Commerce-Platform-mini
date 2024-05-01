module "vpc" {
  source      = "../../modules/vpc"
  region      = "us-west-2"
  cidr_block  = "10.0.0.0/16"
  environment = "prod"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
}
