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
  create_subnets         = true
  
  create_intra_route_table = true
  create_private_route_table = true
  create_public_route_table = true
  
  create_nat_instance    = true
  create_nat_gateway     = false
  single_nat_instance    = false
  nat_instance_allow_ssh = true
  nat_instance_family    = "nat-instance-ubuntu-2204"
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
  
  private_routes_gateway = "nat_instance"
  
  intra_routes = []
  private_routes = []
  public_routes = []
  
  dhcp = {
    domain_name         = "example.com"
    domain_name_servers = ["8.8.8.8", "8.8.4.4"]
    ntp_servers         = ["213.239.239.164", "185.209.85.222"]
  }
  
  intra_subnet_suffix   = "intra"
  private_subnet_suffix = "prv"
  public_subnet_suffix  = "pub"
}
