output "zone" {
  value       = var.zone
  description = "Google Cloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "Google Cloud Project ID"
}

output "network_name" {
  value = module.vpc_network.network_name
  description = "VPC Network Name"
}

output "subnetwork_name" {
  value = module.vpc_network.subnetwork_name
  description = "VPC Subnet Name"
}

output "kubernetes_cluster_name" {
  value       = module.gke_cluster.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.gke_cluster.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "node_pool_ip" {
  value       = module.gke_cluster.node_pool_ip
  description = "Node Pool Instance Group URL"
}

output "reserved_lb_ip" {
  value       = module.gke_cluster.reserved_lb_ip
  description = "Reserved Static IP for backend Load Balancer"
}