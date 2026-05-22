  resource "aws_iam_role" "cluster_role" {
    name = "eks-cluster-role"

    # Terraform's "jsonencode" function converts a
    # Terraform expression result to valid JSON syntax.
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "eks.amazonaws.com"
          }
        },
      ]
    })

    tags = {
      tag-key = "tag-value"
    }
  }

  resource "aws_iam_policy_attachment" "cluster_role_attachment" {
    name       = "eks-cluster-role-attachment"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    roles      = [aws_iam_role.cluster_role.name]
  }

  resource "aws_iam_role" "node_group_role" {
    name = "eks-node-group-role"

    # Terraform's "jsonencode" function converts a
    # Terraform expression result to valid JSON syntax.
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
    })

    tags = {
      tag-key = "tag-value"
    }
  }

  resource "aws_iam_role_policy_attachment" "node_group_role_attachment_1" {           
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role      = aws_iam_role.node_group_role.name
  }

  resource "aws_iam_role_policy_attachment" "node_group_role_attachment_2" {
      policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      role      = aws_iam_role.node_group_role.name
    
  }

  resource "aws_iam_role_policy_attachment" "node_group_role_attachment_3" {
      policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      role      = aws_iam_role.node_group_role.name
    
  }

  resource "aws_iam_role_policy_attachment" "node_group_role_attachment_4" {
      policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      role      = aws_iam_role.node_group_role.name
    
  }

  resource "aws_security_group" "cluster_security_group" {
    name        = "eks-cluster-security-group"
    description = "Security group for EKS cluster communication"
    vpc_id      = var.vpc_id

    tags = {
      name = "eks-cluster-security-group"
    }
    
  }

  resource "aws_security_group" "node_group_security_group" {
    name        = "eks-node-group-security-group"
    description = "Security group for EKS node group communication"
    vpc_id      = var.vpc_id

    tags = {
      Name = "eks-node-group-security-group"
    }
  }


  resource "aws_security_group_rule" "inbound_cluster_group_rule" {
    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    security_group_id = aws_security_group.cluster_security_group.id
    source_security_group_id = aws_security_group.node_group_security_group.id
    
  }

  resource "aws_security_group_rule" "inbound_node_group_rule" {
    type              = "ingress"
    from_port         = 1025
    to_port           = 65535
    protocol          = "tcp"
    security_group_id = aws_security_group.node_group_security_group.id
    source_security_group_id = aws_security_group.cluster_security_group.id
    
  }

  resource "aws_security_group_rule" "node_self_rule" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.node_group_security_group.id
    source_security_group_id = aws_security_group.node_group_security_group.id
    
  }

  resource "aws_security_group_rule" "egress_cluster_group_rule" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.cluster_security_group.id
  }

  resource "aws_security_group_rule" "egress_node_group_rule" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.node_group_security_group.id
  }