resource "yandex_compute_image" "nat_instance" {
  count = var.create_nat_instance && var.nat_instance_image_id == "" ? 1 : 0

  folder_id = var.folder_id

  source_family = var.nat_instance_family
}

resource "yandex_vpc_security_group" "nat_instance" {
  count = var.create_nat_instance ? 1 : 0

  name       = local.nat_blank_name
  network_id = local.vpc_id

  folder_id = var.folder_id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group_rule" "nat_instance" {
  count = var.create_nat_instance ? length(var.private_subnets) : 0

  security_group_binding = yandex_vpc_security_group.nat_instance[0].id

  direction      = "ingress"
  description    = "nat instance"
  v4_cidr_blocks = yandex_vpc_subnet.private[count.index].v4_cidr_blocks
  from_port      = 0
  to_port        = 65535
  protocol       = "ANY"
}

resource "yandex_vpc_security_group_rule" "nat_instance_ssh" {
  count = var.create_nat_instance && var.nat_instance_allow_ssh ? 1 : 0

  security_group_binding = yandex_vpc_security_group.nat_instance[0].id
  direction              = "ingress"
  description            = "ssh access"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  port                   = 22
  protocol               = "TCP"
}

resource "yandex_vpc_address" "nat_instance" {
  count = local.len_nat_instances

  name = format("%s-%s", local.nat_blank_name, count.index)
  labels = merge(
    var.labels,
    {
      "name" : format("%s-%s", local.nat_blank_name, count.index)
    }
  )

  folder_id = var.folder_id

  deletion_protection = false

  external_ipv4_address {
    zone_id = yandex_vpc_subnet.public[count.index]["zone"]
  }
}

module "nat_instance" {
  count = local.len_nat_instances

  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-instance.git?ref=v2.0.0"

  folder_id = var.folder_id

  name        = format("%s-%s", local.nat_blank_name, yandex_vpc_subnet.public[count.index]["zone"])
  description = format("NAT Instance in %s zone", yandex_vpc_subnet.public[count.index]["zone"])
  labels      = var.labels

  zone       = yandex_vpc_subnet.public[count.index]["zone"]
  subnet_id  = yandex_vpc_subnet.public[count.index]["id"]
  enable_nat = true

  create_pip                = false
  network_acceleration_type = "standard"
  serial_port_enable        = false

  platform_id   = var.nat_instance_vm["platform_id"]
  cores         = var.nat_instance_vm["cores"]
  memory        = var.nat_instance_vm["memory"]
  core_fraction = var.nat_instance_vm["core_fraction"]
  preemptible   = var.nat_instance_vm["preemptible"]

  image_id = var.nat_instance_image_id != "" ? var.nat_instance_image_id : yandex_compute_image.nat_instance[0].id

  hostname                  = format("%s-%s", local.nat_blank_name, yandex_vpc_subnet.public[count.index]["zone"])
  allow_stopping_for_update = var.nat_instance_vm["allow_stopping_for_update"]
  generate_ssh_key          = var.nat_instance_vm["generate_ssh_key"]
  ssh_user                  = var.nat_instance_vm["ssh_user"]
  ssh_pubkey                = var.nat_instance_vm["ssh_pubkey"]
  enable_oslogin            = var.nat_instance_vm["enable_oslogin"]

  public_ip_address = yandex_vpc_address.nat_instance[count.index].external_ipv4_address[0].address

  boot_disk = {
    auto_delete = true
    device_name = "boot-disk"
    mode        = "READ_WRITE"
  }

  boot_disk_initialize_params = {
    size       = var.nat_instance_vm["boot_disk_size"]
    block_size = 4096
    type       = "network-ssd"
  }

  security_group_ids = [yandex_vpc_security_group.nat_instance[0].id]
}
