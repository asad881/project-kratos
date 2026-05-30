resource "aws_eks_cluster" "kratos_cluster" {
    name = "kratos_cluster"
    role_arn = var.cluster_role

    vpc_config {
      subnet_ids = var.private_subnet_ids
      security_group_ids = [var.cluster_security_group_id]
      endpoint_private_access = true
      endpoint_public_access = true
    }

    
  
} 


resource "aws_eks_node_group" "kratos_node_group" {
  cluster_name = aws_eks_cluster.kratos_cluster.name
  node_group_name = "kratos_node_group"
  node_role_arn = var.node_group_arn
  subnet_ids =  var.private_subnet_ids

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }

  instance_types = ["t3.medium"]
  
}
