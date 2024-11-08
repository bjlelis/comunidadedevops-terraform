module "eks_network" {
  source       = "./modules/network"
  project_name = "mod-eks-network"
  cidr_block   = "10.0.0.0/16"
}