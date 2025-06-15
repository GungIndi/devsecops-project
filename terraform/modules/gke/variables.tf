variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
  type = number
}

variable "region" {
  description = "cluster region"
  type        = string
}

variable "zone" {
  description = "cluster zone"
  type        = string
}

variable "project_id" {
  description = "project id"
  type        = string
}

variable "network" {
  description = "VPC network name"
  type        = string
}

variable "subnetwork" {
  description = "VPC subnetwork name"
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}