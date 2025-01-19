# Mastodon VPC Terraform Module

This Terraform module creates a production-ready VPC infrastructure specifically designed for hosting a Mastodon server on AWS. The module implements AWS best practices for high availability, security, and scalability.

## Features

- Multi-AZ deployment across 2 availability zones
- Public and private subnets for proper network isolation
- NAT Gateway for private subnet internet access
- Preconfigured security groups for web and database tiers
- Full IPv4 support with customizable CIDR blocks
- Consistent tagging strategy for better resource management

## Usage

```hcl
module "mastodon_vpc" {
  source = "github.com/your-repo/terraform-aws-mastodon-vpc"

  environment = "prod"
  region      = "us-west-2"
  vpc_cidr    = "10.0.0.0/16"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Resources

This module creates the following resources:

- VPC
- Internet Gateway
- NAT Gateway
- Public and Private Subnets
- Route Tables
- Security Groups
- Elastic IP for NAT Gateway
- Route Table Associations

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Environment name (e.g., prod, staging) | string | n/a | yes |
| region | AWS region | string | n/a | yes |
| vpc_cidr | CIDR block for VPC | string | "10.0.0.0/16" | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the created VPC |
| public_subnet_ids | List of IDs of public subnets |
| private_subnet_ids | List of IDs of private subnets |
| web_security_group_id | ID of the web tier security group |
| db_security_group_id | ID of the database tier security group |

## Network Architecture

The module creates the following network layout:

- VPC with specified CIDR (default: 10.0.0.0/16)
- 2 public subnets (one per AZ)
- 2 private subnets (one per AZ)
- Internet Gateway for public internet access
- NAT Gateway in the first public subnet for private subnet internet access
- Route tables for both public and private subnets

## Security Groups

### Web Security Group
- Inbound rules:
  - TCP port 80 (HTTP)
  - TCP port 443 (HTTPS)
- Outbound rules:
  - All traffic

### Database Security Group
- Inbound rules:
  - TCP port 5432 (PostgreSQL) from web security group
- No outbound rules

## Subnet Layout

The module automatically calculates subnet CIDR blocks based on the VPC CIDR. For a default VPC CIDR of 10.0.0.0/16:

- Public Subnet 1: 10.0.0.0/20
- Public Subnet 2: 10.0.16.0/20
- Private Subnet 1: 10.0.32.0/20
- Private Subnet 2: 10.0.48.0/20

## Best Practices

This module follows AWS best practices by:

1. Implementing a multi-AZ architecture for high availability
2. Separating public and private resources
3. Using NAT Gateway for secure outbound internet access
4. Implementing proper security group rules
5. Using consistent tagging for resource management

## Tagging Strategy

All resources are tagged with:

- Name: Resource-specific name including environment
- Environment: Value of environment variable
- Additional tags specific to resource type (e.g., "Tier" for subnets)

## Examples

### Basic Usage

```hcl
module "mastodon_vpc" {
  source = "github.com/your-repo/terraform-aws-mastodon-vpc"

  environment = "prod"
  region      = "us-west-2"
}
```

### Custom CIDR Block

```hcl
module "mastodon_vpc" {
  source = "github.com/your-repo/terraform-aws-mastodon-vpc"

  environment = "staging"
  region      = "eu-west-1"
  vpc_cidr    = "172.16.0.0/16"
}
```

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests to our repository.

## License

This module is released under the MIT License. See the LICENSE file for details.