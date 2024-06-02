module "network" {
  source = "../../"

  blank_name = "testnetwork"
  labels     = var.labels
  folder_id  = "xxx"


  azs = var.azs

  public_subnets  = var.subnets["public"]
  private_subnets = var.subnets["private"]

  create_vpc = true
  #vpc_id     = "xxx"  # установите значение вашего существующего VPC ID, если create_vpc = false
}
