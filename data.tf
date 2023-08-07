data "yandex_vpc_network" "main" {
  network_id = var.create_vpc ? yandex_vpc_network.main[0].id : var.vpc_id
}
