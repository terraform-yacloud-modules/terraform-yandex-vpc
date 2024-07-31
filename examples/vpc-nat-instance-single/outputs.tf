output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "vpc_name" {
  description = "VPC Name"
  value       = module.network.vpc_name
}

output "nat_id" {
  description = "NAT Gateway ID"
  value       = module.network.nat_id
}

#
# NAT
#
output "nat_gw_id" {
  value = module.network.nat_gw_id
}

output "nat_instance_sg_id" {
  value = module.network.nat_instance_sg_id
}

output "nat_instance_ip" {
  value = module.network.nat_instance_ip
}

#
# intra subnets
#
output "intra_subnets" {
  description = "Raw information about intra subnets"
  value       = module.network.intra_subnets
}

output "intra_subnets_ids" {
  description = "List of intra subnets IDs"
  value       = module.network.intra_subnets_ids
}

output "intra_subnets_cidr_blocks" {
  description = "List of intra subnets cidr_blocks"
  value       = module.network.intra_subnets_cidr_blocks
}

output "intra_subnets_ipv6_cidr_blocks" {
  description = "List of intra subnets IPv6 cidr_blocks"
  value       = module.network.intra_subnets_ipv6_cidr_blocks
}

output "intra_rt" {
  description = "Intra route tables info"
  value       = module.network.intra_rt
}

#
# private subnets
#
output "private_subnets" {
  description = "Raw information about private subnets"
  value       = module.network.private_subnets
}

output "private_subnets_ids" {
  description = "List of private subnets IDs"
  value       = module.network.private_subnets_ids
}

output "private_subnets_cidr_blocks" {
  description = "List of private subnets cidr_blocks"
  value       = module.network.private_subnets_cidr_blocks
}

output "private_subnets_ipv6_cidr_blocks" {
  description = "List of private subnets IPv6 cidr_blocks"
  value       = module.network.private_subnets_ipv6_cidr_blocks
}

output "private_rt" {
  description = "Private route tables info"
  value       = module.network.private_rt
}

#
# public subnets
#
output "public_subnets" {
  description = "Raw information about public subnets"
  value       = module.network.public_subnets
}

output "public_subnets_ids" {
  description = "List of public subnets IDs"
  value       = module.network.public_subnets_ids
}

output "public_subnets_cidr_blocks" {
  description = "List of public subnets cidr_blocks"
  value       = module.network.public_subnets_cidr_blocks
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of public subnets IPv6 cidr_blocks"
  value       = module.network.public_subnets_ipv6_cidr_blocks
}

output "public_rt" {
  description = "Public route tables info"
  value       = module.network.public_rt
}
