variable "folder_id" {
  type        = string
  default     = null
  description = "Folder ID where the resources will be created"
}

variable "vpc_address" {
  description = <<EOF
  "Describe your static IP addresses, e.g.:"
  vpc_address = [
    {
      name = "nat-instance"
      zone = "ru-central1-d"
      deletion_protection = true
    },
    {
      name = "vpn"
      zone = "ru-central1-a"
      deletion_protection = true
    }
  ]
  EOF
  type        = any
  default     = null
}

variable "labels" {
  description = "Set of key/value label pairs to assign."
  type        = map(string)
  default = {}
}
