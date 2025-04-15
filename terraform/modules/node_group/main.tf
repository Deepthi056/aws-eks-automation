resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.desired_capacity + 2
    min_size     = var.desired_capacity
  }

  # Additional configuration such as specifying the instance type can be added here.
  # For example, if using a launch template, you might pass the instance_type variable.
}
