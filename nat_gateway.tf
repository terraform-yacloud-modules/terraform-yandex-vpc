resource "yandex_vpc_gateway" "nat" {
  count = (var.create_nat_gateway && var.create_nat_instance == false) ? 1 : 0

  name        = format("%s-nat", var.blank_name)
  description = ""
  folder_id   = var.folder_id
  labels      = var.labels

  shared_egress_gateway {}
}
