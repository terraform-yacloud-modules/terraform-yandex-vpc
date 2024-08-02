data "yandex_client_config" "client" {}

module "network" {
  source = "../../"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "vpc-nat-instance-single"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  public_subnets  = [["10.81.0.0/24"], ["10.82.0.0/24"], ["10.83.0.0/24"]]
  private_subnets = [["10.84.0.0/24"], ["10.85.0.0/24"], ["10.86.0.0/24"]]

  create_vpc          = true
  create_nat_instance = true
  single_nat_instance = true
}
