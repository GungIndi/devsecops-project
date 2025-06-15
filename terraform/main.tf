# Root-level provider configuration
provider "google" {
  project = var.project_id
  region  = var.region
}

# Calling the compute module to create a VM
module "gke_cluster" {
  source       = "./modules/gke"
  cluster_name = var.cluster_name
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  env          = var.env
  network      = module.vpc_network.network_name
  subnetwork   = module.vpc_network.subnetwork_name
}

# Calling the networking module to create a VPC
module "vpc_network" {
  source     = "./modules/vpc"
  vpc_name   = var.cluster_name
  project_id = var.project_id
  region     = var.region
}

