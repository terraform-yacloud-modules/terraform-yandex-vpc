locals {
  vpc_id = var.create_vpc ? yandex_vpc_network.main.id: data.yandex_vpc_network.main.id
}
