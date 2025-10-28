############################################
# Root level - main.tf
############################################

module "ec2" {
  source            = "./ec2"
  project           = var.project
  ami               = "ami-0c7217cdde317cfec"
  instance_type     = "t2.micro"
  public_key_path   = "~/.ssh/id_rsa.pub"
  public_subnet_id  = module.vpc.public_subnets[0]
  private_subnet_id = module.vpc.private_subnets[0]
  public_sg_id      = module.security.public_sg_id
  private_sg_id     = module.security.private_sg_id
}
