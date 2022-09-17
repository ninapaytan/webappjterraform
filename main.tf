module "network" {
  source = "./modules/network"
}

module "security-groups" {
  source = "./modules/security-groups"
  vpc-adolfo = module.network.vpc-adolfo-id
}

module "compute" {
  source = "./modules/compute"
  subnet-a-public = module.network.subnet-a-public-id
  subnet-b-public = module.network.subnet-b-public-id
  subnet-a-private = module.network.subnet-a-private-id
  subnet-b-private = module.network.subnet-b-private-id
  allow_http_ssh-id = module.security-groups.allow_http_ssh-id
}

