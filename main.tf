############################################
# Root level - main.tf
############################################

#####################################
# 1. VPC Modulunu Çağır
#####################################
module "vpc" {
  source = "./vpc"

  region        = var.region
  project       = var.project
  vpc_cidr      = var.vpc_cidr
  azs           = var.azs
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
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
# 3. EC2 Modulunu Çağır
#####################################
module "ec2" {
  source            = "./ec2"
  project           = var.project
  ami               = "ami-0c7217cdde317cfec"
  instance_type     = "t2.micro"
  public_key_path   = "/home/broops/.ssh/id_rsa.pub"  # ⚡ tam path
  public_subnet_id  = module.vpc.public_subnets[0]
  private_subnet_id = module.vpc.private_subnets[0]
  public_sg_id      = module.security.public_sg_id
  private_sg_id     = module.security.private_sg_id
}
