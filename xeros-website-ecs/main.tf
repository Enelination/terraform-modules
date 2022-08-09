#configure aws provider
provider "aws" {
  region  = var.region
  profile = "aws-profile"
}

#create vpc
module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

#create nat gateway 
module "nat-gateway" {
  source                     = "../modules/nat-gateway"
  vpc_id                     = module.vpc.outputs.vpc_id
  public_subnet_az1_id       = module.vpc.outputs.public_subnet_az1_id
  public_subnet_az2_id       = module.vpc.outputs.public_subnet_az2_id
  internet_gateway           = module.vpc.outputs.internet_gateway
  private_app_subnet_az1_id  = module.vpc.outputs.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.outputs.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.outputs.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.outputs.private_data_subnet_az2_id

}

#create security groups
module "security-groups" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.outputs.vpc_id

}

