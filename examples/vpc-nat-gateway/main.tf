data "yandex_client_config" "client" {}

module "network" {
  source = "../../"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  public_subnets  = [["10.61.0.0/24"], ["10.62.0.0/24"], ["10.63.0.0/24"]]
  private_subnets = [["10.64.0.0/24"], ["10.65.0.0/24"], ["10.66.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}
