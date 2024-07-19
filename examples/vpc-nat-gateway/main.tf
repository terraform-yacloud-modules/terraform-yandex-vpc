locals {
  name = "vpc-simple"

  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }
}

data "yandex_client_config" "client" {}

module "network" {
  source = "../../"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = local.name
  labels     = local.labels

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  public_subnets  = [["10.1.0.0/24"], ["10.2.0.0/24"], ["10.3.0.0/24"]]
  private_subnets = [["10.4.0.0/24"], ["10.5.0.0/24"], ["10.6.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}
