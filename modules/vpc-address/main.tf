data "yandex_client_config" "client" {}

locals {
  folder_id = var.folder_id == null ? data.yandex_client_config.client.folder_id : var.folder_id
}

resource "yandex_vpc_address" "addr" {
  for_each    = try({ for addr in var.vpc_address : addr.name => addr }, {})
  name        = lookup(each.value, "name", each.key)
  description = lookup(each.value, "description", "static address for ${each.value.name}")
  folder_id   = lookup(each.value, "folder_id", local.folder_id)

  external_ipv4_address {
    zone_id                  = lookup(each.value, "zone", null)
    ddos_protection_provider = lookup(each.value, "ddos_protection_provider", null)
    outgoing_smtp_capability = lookup(each.value, "outgoing_smtp_capability", null)
  }

  deletion_protection = lookup(each.value, "deletion_protection", false)
  labels              = var.labels
}
