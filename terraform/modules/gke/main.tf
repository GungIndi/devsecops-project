# GKE Module
data "google_container_engine_versions" "gke_version" {
  location = var.zone
  version_prefix = "1.27."
}

# GKE Cluster
resource "google_container_cluster" "terraform-gke" {
  name     = "${var.cluster_name}"
  location = var.zone
  project  = var.project_id
  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1
  
  network    = var.network
  subnetwork = var.subnetwork
  networking_mode = "VPC_NATIVE"

  release_channel {
    channel = "STABLE"
  }
}

# Static IP Address for Load Balancer
resource "google_compute_address" "static_lb_ip" {
  name         = "gke-loadbalancer-ip"
  region       = var.region
  project      = var.project_id
  address_type = "EXTERNAL"
}

# Firewall rule to allow traffic to the GKE cluster
resource "google_compute_firewall" "allow_nodeport_31000" {
  name    = "allow-nodeport-31000"
  network = var.network

  # Allow incoming TCP traffic on port 31000
  allow {
    protocol = "tcp"
    ports    = ["31000"]
  }

  # Targets: the nodes that have this tag
  target_tags = ["gke-node", var.cluster_name]

  # You can restrict source_ranges if you want (e.g., your office IP)
  # For testing, allow from everywhere:
  source_ranges = ["0.0.0.0/0"]

  description = "Allow incoming traffic on NodePort 31000 for GKE nodes"
}

# Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.terraform-gke.name
  location   = var.zone
  cluster    = google_container_cluster.terraform-gke.name
  
  version = data.google_container_engine_versions.gke_version.release_channel_default_version["STABLE"]
  node_count = var.gke_num_nodes
  depends_on = [ google_compute_firewall.allow_nodeport_31000 ]
  
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    machine_type = "e2-standard-2"
    tags         = ["gke-node", "${var.cluster_name}"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    disk_size_gb = 50
    disk_type    = "pd-standard"
  }

  management {
    auto_repair = true
  }
}
