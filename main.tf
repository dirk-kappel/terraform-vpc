# -----------------
# RESOURCE
# -----------------
module "firewall" {
  source = "./modules/vpc"
  vpc    = var.firewall
}

module "production" {
  source = "./modules/vpc"
  vpc    = var.production
}

module "on-prem" {
  source = "./modules/vpc"
  vpc    = var.onprem
}