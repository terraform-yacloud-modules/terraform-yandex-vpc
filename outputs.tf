output "vpc_id" {
  description = "VPC ID"
  value       = local.vpc_id
}

output "vpc_name" {
  description = "VPC Name"
  value       = var.create_vpc ? yandex_vpc_network.main[0].name : data.yandex_vpc_network.main[0].name
}

output "nat_id" {
  description = "NAT Gateway ID"
  value       = var.create_nat_gateway ? yandex_vpc_gateway.nat[0].id : null
}

#
# intra subnets
#
output "intra_subnets" {
  description = "Raw information about intra subnets"
  value       = var.create_subnets ? yandex_vpc_subnet.intra : null
}

output "intra_subnets_ids" {
  description = "List of intra subnets IDs"
  value       = var.create_subnets ? yandex_vpc_subnet.intra[*].id : null
}

output "intra_subnets_cidr_blocks" {
  description = "List of intra subnets cidr_blocks"
  value       = var.create_subnets ? flatten(yandex_vpc_subnet.intra[*].v4_cidr_blocks) : null
}

output "intra_subnets_ipv6_cidr_blocks" {
  description = "List of intra subnets IPv6 cidr_blocks"
  value       = var.create_subnets ? flatten(yandex_vpc_subnet.intra[*].v6_cidr_blocks) : null
}

output "intra_rt" {
  description = "Intra route table info"
  value       = var.create_intra_route_table ? yandex_vpc_route_table.intra[0] : null
}

#
# private subnets
#
output "private_subnets" {
  description = "Raw information about private subnets"
  value       = var.create_subnets ? yandex_vpc_subnet.private : null
}

output "private_subnets_ids" {
  description = "List of private subnets IDs"
  value       = var.create_subnets ? yandex_vpc_subnet.private[*].id : null
}

output "private_subnets_cidr_blocks" {
  description = "List of private subnets cidr_blocks"
  value       = var.create_subnets ? flatten(yandex_vpc_subnet.private[*].v4_cidr_blocks) : null
}

output "private_subnets_ipv6_cidr_blocks" {
  description = "List of private subnets IPv6 cidr_blocks"
  value       = var.create_subnets ? flatten(yandex_vpc_subnet.private[*].v6_cidr_blocks) : null
}

output "private_rt" {
  description = "Private route table info"
  value       = var.create_private_route_table ? yandex_vpc_route_table.private[0] : null
}

#
# public subnets
#
output "public_subnets" {
  description = "Raw information about public subnets"
  value       = var.create_subnets ? yandex_vpc_subnet.public : null
}

output "public_subnets_ids" {
  description = "List of public subnets IDs"
  value       = var.create_subnets ? yandex_vpc_subnet.public[*].id : null
}

output "public_subnets_cidr_blocks" {
  description = "List of public subnets cidr_blocks"
  value       = var.create_subnets ? flatten(yandex_vpc_subnet.public[*].v4_cidr_blocks) : null
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of public subnets IPv6 cidr_blocks"
  value       = var.create_subnets ? flatten(yandex_vpc_subnet.public[*].v6_cidr_blocks) : null
}

output "public_rt" {
  description = "Public route table info"
  value       = var.create_public_route_table ? yandex_vpc_route_table.public[0] : null
}
