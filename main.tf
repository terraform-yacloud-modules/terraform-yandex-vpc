resource "yandex_vpc_network" "main" {
  count = var.create_vpc ? 1 : 0

  name        = var.blank_name
  folder_id   = var.folder_id
  description = ""
  labels      = var.labels
}

resource "yandex_vpc_subnet" "private" {
  count = var.create_subnets && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  name        = format("%s-%s-%s", var.blank_name, var.private_subnet_suffix, element(var.azs, count.index))
  description = ""
  folder_id   = var.folder_id
  labels      = var.labels

  zone = element(var.azs, count.index)

  network_id     = local.vpc_id
  v4_cidr_blocks = var.private_subnets[count.index]
  route_table_id = yandex_vpc_route_table.private[0].id

  dynamic "dhcp_options" {
    for_each = var.dhcp != null ? [var.dhcp] : []
    content {
      domain_name         = dhcp_options.value["domain_name"]
      domain_name_servers = dhcp_options.value["domain_name_servers"]
      ntp_servers         = dhcp_options.value["dhcp_ntp_servers"]
    }
  }
}

resource "yandex_vpc_subnet" "public" {
  count = var.create_subnets && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  name        = format("%s-%s-%s", var.blank_name, var.public_subnet_suffix, element(var.azs, count.index))
  description = ""
  folder_id   = var.folder_id
  labels      = var.labels

  zone = element(var.azs, count.index)

  network_id     = local.vpc_id
  v4_cidr_blocks = var.public_subnets[count.index]
  route_table_id = yandex_vpc_route_table.public[0].id

  dynamic "dhcp_options" {
    for_each = var.dhcp != null ? [var.dhcp] : []
    content {
      domain_name         = dhcp_options.value["domain_name"]
      domain_name_servers = dhcp_options.value["domain_name_servers"]
      ntp_servers         = dhcp_options.value["dhcp_ntp_servers"]
    }
  }
}
