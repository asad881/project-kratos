module "kratos_network" {
    source = "./modules/vpc"

    vpc_cidr = var.project_kratos_vpc_cidr_block
    public_subnet_cidrs = var.project_kratos_public_subnet_cidr_block
    private_subnet_cidrs = var.project_kratos_private_subnet_cidr_block
    project_tags = var.project_tags
  
}
