module "vpc" {
  source     = "./modules/VPC"
  vpc_cidr   = var.vpc_cidr
  subnet_vpc = var.subnet_vpc
  region     = var.region
  subnet_name = var.name_sub
}

module "sg" {
  source = "./modules/SG"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source    = "./modules/EC2"
  sg_id     = module.sg.sg_id
  subnet_id = module.vpc.subnet_id # singular if only one subnet
}


