locals {
  public_routes = var.create_nat ? setunion(toset([for route in var.public_routes : route if route.enabled]), toset([
    {
      destination_prefix = "0.0.0.0/0",
      gateway_id         = yandex_vpc_gateway.nat[0].id
    }
  ])) : [for route in var.public_routes : route if route.enabled]

  private_routes = [for route in var.private_routes : route if route.enabled]
}

resource "yandex_vpc_route_table" "public" {
  count = var.create_vpc ? 1 : 0

  name        = format("%s-pub", var.blank_name)
  description = ""
  folder_id   = var.folder_id
  labels      = var.labels

  network_id = yandex_vpc_network.main[0].id

  dynamic "static_route" {
    for_each = length(local.public_routes) > 0 ? local.public_routes : []

    iterator = route
    content {
      destination_prefix = route.value.destination_prefix
      next_hop_address   = lookup(route.value, "next_hop_address", null)
      gateway_id         = lookup(route.value, "gateway_id", null)
    }
  }
}

resource "yandex_vpc_route_table" "private" {
  count = var.create_vpc ? 1 : 0

  name        = format("%s-prv", var.blank_name)
  description = ""
  folder_id   = var.folder_id
  labels      = var.labels

  network_id = yandex_vpc_network.main[0].id

  dynamic "static_route" {
    for_each = length(local.private_routes) > 0 ? local.private_routes : []

    iterator = route
    content {
      destination_prefix = route.value.destination_prefix
      next_hop_address   = lookup(route.value, "next_hop_address", null)
      gateway_id         = lookup(route.value, "gateway_id", null)
    }
  }
}