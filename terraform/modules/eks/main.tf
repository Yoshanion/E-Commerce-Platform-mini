provider "aws" {
    region = var.region
}

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = [aws_security_group.eks.id]
  }
}

resource "aws_iam_role" "eks_cluster" {
    name = "${var.cluster_name}-eks-cluster"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = "eks.amazonaws.com"
                },
                Action = "sts:AssumeRole"
            },
        ]
    })
}

resource "aws_eks_node_group" "default" {
    cluster_name    = aws_eks_cluster.main.name
    node_group_name = "default-node-group"
    node_role_arn   = aws_iam_role.eks_node.arn
    subnet_ids      = var.subnet_ids

    scaling_config {
        desired_size = var.node_group_settings.desired_size
        max_size     = var.node_group_settings.max_size
        min_size     = var.node_group_settings.min_size
    }

    depends_on = [aws_eks_cluster.main]
}

resource "aws_iam_role" "eks_node" {
    name = "${var.cluster_name}-eks-node"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Service = "ec2.amazonaws.com"
                },
                Action = "sts:AssumeRole"
            },
        ]
    })
}

resource "aws_security_group" "eks" {
    name        = "eks-cluster-sg"
    description = "Security group for all nodes in the cluster"
    vpc_id      = var.vpc_id
}   


