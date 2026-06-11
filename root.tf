module "kratos_network" {
    source = "./modules/vpc"

    vpc_cidr = var.project_kratos_vpc_cidr_block
    public_subnet_cidrs = var.project_kratos_public_subnet_cidr_block
    private_subnet_cidrs = var.project_kratos_private_subnet_cidr_block
    project_tags = var.project_tags
  
}

module "security_iam" {
    source = "./modules/security-iam"

    vpc_id = module.kratos_network.vpc_id
    
  
}   

module "eks_cluster" {
    source = "./modules/eks_cluster"
    cluster_role = module.security_iam.cluster_role
    node_group_arn = module.security_iam.node_group_arn
    cluster_security_group_id = module.security_iam.cluster_security_group_id
    private_subnet_ids = module.kratos_network.private_subnet_ids
}