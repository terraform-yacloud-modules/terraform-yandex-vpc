output "vpc_id" {
  description = "VPC ID"
  value       = local.vpc_id
}

output "vpc_name" {
  description = "VPC Name"
  value       = var.create_vpc ? yandex_vpc_network.main[0].name : data.yandex_vpc_network.main.name
}

output "public_subnets" {
  description = "Public subnets info"
  value       = var.create_subnets ? yandex_vpc_subnet.public : null
}

output "private_subnets" {
  description = "Private subnets info"
  value       = var.create_subnets ? yandex_vpc_subnet.private : null
}

output "public_rt" {
  description = "Public route table info"
  value       = var.create_route_tables ? yandex_vpc_route_table.public[0] : null
}

output "private_rt" {
  description = "Private route table info"
  value       = var.create_route_tables ? yandex_vpc_route_table.private[0] : null
}

output "nat_id" {
  description = "NAT Gateway ID"
  value       = var.create_nat ? yandex_vpc_gateway.nat[0].id : null
}
