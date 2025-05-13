resource "yandex_vpc_route_table" "intra" {
  count = var.create_intra_route_table ? length(var.intra_subnets) : 0

  name        = format("%s-intra-%s", var.blank_name, count.index)
  description = format("VPC route for intra subnet")
  folder_id   = var.folder_id
  labels      = var.labels

  network_id = local.vpc_id

  dynamic "static_route" {
    for_each = [for route in var.intra_routes : route if route.enabled]

    iterator = route
    content {
      destination_prefix = route.value.destination_prefix
      next_hop_address   = lookup(route.value, "next_hop_address", null)
      gateway_id         = lookup(route.value, "gateway_id", null)
    }
  }
}

resource "yandex_vpc_route_table" "private" {
  count = var.create_private_route_table ? length(var.private_subnets) : 0

  name        = format("%s-prv-%s", var.blank_name, count.index)
  description = format("VPC route for private subnet")
  folder_id   = var.folder_id
  labels      = var.labels

  network_id = local.vpc_id

  dynamic "static_route" {
    for_each = var.private_routes_gateway == "nat_instance" && var.create_nat_instance ? [1] : []

    content {
      destination_prefix = "0.0.0.0/0"
      next_hop_address   = local.len_nat_instances > 1 ? module.nat_instance[count.index].instance_private_ip : module.nat_instance[0].instance_private_ip
    }
  }

  dynamic "static_route" {
    for_each = var.private_routes_gateway == "nat_gateway" && var.create_nat_gateway ? [1] : []

    content {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.nat[0].id
    }
  }

  dynamic "static_route" {
    for_each = [for route in var.private_routes : route if route.enabled]

    iterator = route
    content {
      destination_prefix = route.value.destination_prefix
      next_hop_address   = lookup(route.value, "next_hop_address", null)
      gateway_id         = lookup(route.value, "gateway_id", null)
    }
  }
}

resource "yandex_vpc_route_table" "public" {
  count = var.create_public_route_table ? length(var.public_subnets) : 0

  name        = format("%s-pub-%s", var.blank_name, count.index)
  description = format("VPC route for public subnet")
  folder_id   = var.folder_id
  labels      = var.labels

  network_id = local.vpc_id


  dynamic "static_route" {
    for_each = [for route in var.public_routes : route if route.enabled]

    iterator = route
    content {
      destination_prefix = route.value.destination_prefix
      next_hop_address   = lookup(route.value, "next_hop_address", null)
      gateway_id         = lookup(route.value, "gateway_id", null)
    }
  }
}
