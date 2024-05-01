variable "cluster_name" {
  type        = string
  description = "The name of the EKS Cluster"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the cluster will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet IDs for the EKS cluster"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "node_group_settings" {
  type        = map(any)
  default     = {}
  description = "Settings for the EKS node groups"
}
