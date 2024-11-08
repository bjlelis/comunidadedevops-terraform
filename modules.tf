module "eks_network" {
  source       = "./modules/network"
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = var.tags
}