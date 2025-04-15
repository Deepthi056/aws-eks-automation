terraform {
  backend "s3" {
    # The backend configuration is provided via command-line options.
  }
}

provider "aws" {
  region = var.aws_region
}

# EKS Cluster Module
module "eks_cluster" {
  source           = "./modules/eks_cluster"
  cluster_name     = var.cluster_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
  vpc_id           = var.vpc_id
  subnet_ids       = var.subnet_ids
  cluster_role_arn = var.cluster_role_arn
}

# Infra Node Group Module – name from tfvars (default: infrapool)
module "infrapool" {
  source           = "./modules/node_group"
  cluster_name     = var.cluster_name
  node_group_name  = var.infrapool_name
  desired_capacity = var.infra_node_count
  subnet_ids       = var.subnet_ids
  node_role_arn    = var.node_role_arn
  instance_type    = var.instance_type
}

# Core Node Group Module – name from tfvars (default: corepool)
module "corepool" {
  source           = "./modules/node_group"
  cluster_name     = var.cluster_name
  node_group_name  = var.corepool_name
  desired_capacity = var.core_node_count
  subnet_ids       = var.subnet_ids
  node_role_arn    = var.node_role_arn
  instance_type    = var.instance_type
}
