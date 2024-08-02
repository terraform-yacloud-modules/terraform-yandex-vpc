data "yandex_client_config" "client" {}

module "network" {
  source = "../../"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "complete"
  labels = {
    foo = "bar"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  public_subnets  = [["10.51.0.0/24"], ["10.52.0.0/24"], ["10.53.0.0/24"]]
  private_subnets = [["10.54.0.0/24"], ["10.55.0.0/24"], ["10.56.0.0/24"]]
  intra_subnets   = [["10.57.0.0/24"], ["10.58.0.0/24"], ["10.59.0.0/24"]]

  create_vpc             = true
  create_nat_instance    = true
  single_nat_instance    = false
  nat_instance_allow_ssh = true
  nat_instance_vm = {
    platform_id               = "standard-v3"
    cores                     = 2
    memory                    = 4
    core_fraction             = 100
    boot_disk_size            = 20
    preemptible               = false
    allow_stopping_for_update = false
    generate_ssh_key          = false
    ssh_user                  = "ubuntu"
    ssh_pubkey                = null
    enable_oslogin            = true
  }
}
