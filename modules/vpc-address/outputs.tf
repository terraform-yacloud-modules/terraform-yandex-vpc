output "vpc_addresses" {
  description = "Map of static VPC addresses with their names"
  value       = { for a in yandex_vpc_address.addr : a.name => a.external_ipv4_address[0].address }
}
