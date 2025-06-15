output "kubernetes_cluster_name" {
  value       = google_container_cluster.terraform-gke.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.terraform-gke.endpoint
  description = "GKE Cluster Host"
}

output "node_pool_ip" {
  value       = google_container_node_pool.primary_nodes.instance_group_urls[0]
  description = "Node Pool Instance Group URL"
}

output "reserved_lb_ip" {
  value = google_compute_address.static_lb_ip.address
  description = "Reserved Static IP for backend Load Balancer"
}
