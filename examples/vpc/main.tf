module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git"

  blank_name = "testnetwork"
  labels = {
    testlabel = "testvalue"
  }
  folder_id = "xxxx"

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  public_subnets  = [["10.1.0.0/24"], ["10.2.0.0/24"], ["10.3.0.0/24"]]
  private_subnets = [["10.4.0.0/24"], ["10.5.0.0/24"], ["10.6.0.0/24"]]

  create_vpc = true
  #vpc_id     = "xxx"  # установите значение вашего существующего VPC ID, если create_vpc = false
}
