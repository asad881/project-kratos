output "cluster_role" {
    value = aws_iam_role.cluster_role.arn

    depends_on = [ 
        aws_iam_role_policy_attachment.cluster_role_attachment
     ]
  
}

output "cluster_security_group_id" {
    value = aws_security_group.cluster_security_group.id
  
}

output "node_group_arn" {
    value = aws_iam_role.node_group_role.arn

    depends_on = [
        aws_iam_role_policy_attachment.node_group_role_attachment_1,
        aws_iam_role_policy_attachment.node_group_role_attachment_2,
        aws_iam_role_policy_attachment.node_group_role_attachment_3,
        aws_iam_role_policy_attachment.node_group_role_attachment_4,

    ]
  
}