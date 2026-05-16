variable "aws_region" {
    description = "The AWS region to deploy resources in."
    type        = string
    default     = "us-east-1"
  
}

variable "project_kratos_vpc_cidr_block" {
    description = "The CIDR block for the VPC."
    type        = string
    default     = "10.0.0.0/16"
  
}

variable "project_kratos_public_subnet_cidr_block" {
    description = "The CIDR block for the public subnet."
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "project_kratos_private_subnet_cidr_block" {
    description = "The CIDR block for the private subnet."
    type        = list(string)
    default     = ["10.0.10.0/24", "10.0.11.0/24"]
  
}

variable "project_tags" {
    description = "A map of tags to assign to the resources."
    type        = map(string)
    default     = {
        Environment = "Development"
        Project     = "Project Kratos"
        ManagedBy   = "Terraform"
    }
  
}