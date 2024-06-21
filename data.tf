data "yandex_vpc_network" "main" {
  count = var.create_vpc ? 0 : 1

  network_id = var.vpc_id != "" ? var.vpc_id : null
  name       = var.vpc_id == "" ? var.blank_name : null
}
