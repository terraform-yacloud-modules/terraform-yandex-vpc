locals {
  vpc_id              = var.create_vpc ? yandex_vpc_network.main[0].id : (var.vpc_id != "" ? var.vpc_id : data.yandex_vpc_network.main[0].id)
  create_nat_instance = var.create_nat_instance && (var.create_nat_gateway == false) && (length(var.public_subnets) > 0)
  len_nat_instances   = local.create_nat_instance ? (var.single_nat_gateway ? 1 : length(yandex_vpc_subnet.public)) : 0
  nat_blank_name      = format("%s-nat-inst", var.blank_name)
}
