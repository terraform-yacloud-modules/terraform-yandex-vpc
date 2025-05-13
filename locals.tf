locals {
  vpc_id            = data.yandex_vpc_network.main.id
  len_nat_instances = (var.create_nat_instance && length(var.public_subnets) > 0) ? (var.single_nat_instance ? 1 : length(yandex_vpc_subnet.public)) : 0
  nat_blank_name    = format("%s-nat-inst", var.blank_name)
}
