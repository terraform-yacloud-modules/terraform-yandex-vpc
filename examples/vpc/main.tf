module "network" {
  source = "../../"

  blank_name = "testnetwork"
  labels     = var.labels

  azs = var.azs

  public_subnets  = var.subnets["public"]
  private_subnets = var.subnets["private"]
}
