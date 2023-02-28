variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

variable "labels" {
  description = "A set of labels"
  type        = map(string)
  default = {
    testlabel : "testvalue"
  }
}

variable "subnets" {
  description = "Subnets map"
  default = {
    public  = [["10.1.0.0/24"], ["10.2.0.0/24"], ["10.3.0.0/24"]]
    private = [["10.4.0.0/24"], ["10.5.0.0/24"], ["10.6.0.0/24"]]
  }
}
