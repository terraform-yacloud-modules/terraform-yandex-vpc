data "yandex_client_config" "client" {}

module "network" {
  source = "../../"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "vpc-nat-instance-multiple"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  public_subnets  = [["10.71.0.0/24"], ["10.72.0.0/24"], ["10.73.0.0/24"]]
  private_subnets = [["10.74.0.0/24"], ["10.75.0.0/24"], ["10.76.0.0/24"]]

  create_vpc          = true
  create_nat_instance = true
  single_nat_instance = false
}
