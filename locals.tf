locals {
  vpc_id = var.create_vpc ? yandex_vpc_network.main[0].id : data.yandex_vpc_network.main.id
}
