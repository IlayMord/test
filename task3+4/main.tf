provider "aws" {
  region = "us-east-1"
}

locals {
  ami_id        = "ami-0252d9c82e6b8fa85"
  instance_type = "t2.micro"
  key_name      = "ilay-private-key"
}

module "vpc" {
  source = "./modules/vpc"

  subnet_count        = 2
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
  source = "./modules/ec2"

  subnet_id        = module.vpc.public_subnet_id
  vpc_id           = module.vpc.vpc_id
  instance_type    = local.instance_type
  assign_public_ip = true
  ami_id           = local.ami_id
  key_name         = local.key_name
}

module "alb" {
  source = "./modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "asg" {
  source = "./modules/asg"

  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.public_subnet_ids
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id

  ami_id        = local.ami_id
  instance_type = local.instance_type
  key_name      = local.key_name

  min_size         = 1
  max_size         = 3
  desired_capacity = 1
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
