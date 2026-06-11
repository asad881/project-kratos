variable "cluster_role" {
    description = "cluster iam role for eks cluster"
    type = string
  
}

variable "private_subnet_ids" {
    description = "Ids of private subnets for eks cluster"
    type = list(string)
  
}

variable "cluster_security_group_id" {
    description = "Id of the security group for eks cluster"
    type = string
  
}

variable "node_group_arn" {
    description = "iam role for node group"
    type = string
  
}