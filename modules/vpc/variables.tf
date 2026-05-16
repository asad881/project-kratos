
variable "vpc_cidr" {
    description = "The CIDR block for the VPC."
    type        = string
  
}

variable "public_subnet_cidrs" {
    description = "A list of CIDR blocks for the public subnets."
    type        = list(string)
  
}

variable "private_subnet_cidrs" {
    description = "A list of CIDR blocks for the private subnets."
    type        = list(string)
  
}

variable "project_tags" {
    description = "A map of tags to assign to the resources."
    type        = map(string)
  
}

