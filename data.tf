data "yandex_vpc_network" "main" {
  count = var.create_vpc ? 0 : 1

  network_id = var.vpc_id
}
