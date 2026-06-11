output "vpc_id" {
    value = aws_vpc.ProjectKratosVPC.id
  
}

output "private_subnet_ids" {
    value = aws_subnet.ProjectKratosPrivateSubnet[*].id
  
}