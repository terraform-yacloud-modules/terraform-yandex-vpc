locals {
  vpc_id              = data.yandex_vpc_network.main.id
  create_nat_instance = var.create_nat_instance && (var.create_nat_gateway == false) && (length(var.public_subnets) > 0)
  len_nat_instances   = local.create_nat_instance ? (var.single_nat_instance ? 1 : length(yandex_vpc_subnet.public)) : 0
  nat_blank_name      = format("%s-nat-inst", var.blank_name)
}
