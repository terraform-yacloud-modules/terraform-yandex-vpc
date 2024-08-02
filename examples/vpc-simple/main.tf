data "yandex_client_config" "client" {}

module "network" {
  source = "../../"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "vpc-simple"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  public_subnets  = [["10.91.0.0/24"], ["10.92.0.0/24"], ["10.93.0.0/24"]]
  private_subnets = [["10.94.0.0/24"], ["10.95.0.0/24"], ["10.96.0.0/24"]]

  create_vpc = true
  #vpc_id    = "xxx"  # установите значение вашего существующего VPC ID, если create_vpc = false
}
