output "vpc_id" {
  description = "VPC ID"
  value       = yandex_vpc_network.main[0].id
}

output "vpc_name" {
  description = "VPC Name"
  value       = yandex_vpc_network.main[0].name
}

output "public_subnets" {
  description = "Public subnets info"
  value       = yandex_vpc_subnet.public
}

output "private_subnets" {
  description = "Private subnets info"
  value       = yandex_vpc_subnet.private
}

output "public_rt" {
  description = "Public route table info"
  value       = yandex_vpc_route_table.public[0]
}

output "private_rt" {
  description = "Private route table info"
  value       = yandex_vpc_route_table.private[0]
}

output "nat_id" {
  description = "NAT Gateway ID"
  value       = var.create_nat ? yandex_vpc_gateway.nat[0].id : null
}
