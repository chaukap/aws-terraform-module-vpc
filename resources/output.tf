# Outputs
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "List of private subnet IDs"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "List of public subnet IDs"
}

output "vpc_cidr" {
  value       = var.vpc_cidr
  description = "CIDR block of the VPC"
}

output "security_group_id" {
  value       = aws_security_group.vpc_endpoints.id
  description = "ID of the VPC endpoints security group"
}

output "ses_domain" {
  value       = aws_vpc_endpoint.ses.dns_entry[0]["dns_name"]
  description = "Domain for sending emails through the VPC"
}