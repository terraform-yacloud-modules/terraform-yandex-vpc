locals {
  vpc_id = var.create_vpc ? yandex_vpc_network.main[0].id : (var.vpc_id != "" ? var.vpc_id : data.yandex_vpc_network.main[0].id)
}
