locals {
  vpc_id            = data.yandex_vpc_network.main.id
  len_nat_instances = (var.create_nat_instance && length(var.public_subnets) > 0) ? (var.single_nat_instance ? 1 : length(yandex_vpc_subnet.public)) : 0
  nat_blank_name    = format("%s-nat-inst", var.blank_name)
}

locals {
  zone_counts = {
    for az in distinct(var.azs) : az => length([for z in var.azs : z if z == az])
  }

  intra_zone_indices = {
    for i in range(length(var.azs)) : i => length([
      for j in range(i) : j if var.azs[j] == var.azs[i]
    ])
  }

  needs_index_per_subnet = {
    for i in range(length(var.azs)) : i => local.zone_counts[var.azs[i]] > 1
  }
}
