############################################
# Root level - main.tf
############################################

#####################################
# 1. VPC Modulunu Çağır
#####################################
module "vpc" {
  source = "./vpc"
  region = var.region
  project = var.project
  vpc_cidr = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  azs = var.azs
}


#####################################
# 2. Security Modulunu Çağır
#####################################
module "security" {
  source = "./security"
  project = var.project
  vpc_id  = module.vpc.vpc_id  # 🔑 artıq problem yoxdur
}

#####################################
module "ec2" {
  source             = "./modules/ec2"
  project            = var.project
  vpc_id             = module.vpc.vpc_id           # ✅ yalnız burda
  public_subnet_id   = element(module.vpc.public_subnets, 0)
  private_subnet_id  = element(module.vpc.private_subnets, 0)
  public_sg_id       = module.security.public_sg_id
  private_sg_id      = module.security.private_sg_id
  instance_type      = "t2.micro"
  public_key_path    = "~/.ssh/id_rsa.pub"
}
