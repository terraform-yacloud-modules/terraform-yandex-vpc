################################################################################
# yandex cloud
################################################################################
variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

################################################################################
# Naming
################################################################################
variable "blank_name" {
  description = "Blank name which will be used for all resources"
  type        = string
}

variable "labels" {
  description = "A set of labels"
  type        = map(string)
  default     = {}
}

variable "intra_subnet_suffix" {
  description = "Suffix to append to intra subnets name"
  type        = string
  default     = "intra"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "prv"
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "pub"
}

################################################################################
# feature flags
################################################################################
variable "create_vpc" {
  description = "Controls if VPC should be created"
  type        = bool
  default     = true
}

variable "create_subnets" {
  description = "Controls if subnets should be created"
  type        = bool
  default     = true
}

################################################################################
# VPC
################################################################################
variable "vpc_id" {
  description = "If create_vpc set to false you may provide vpc_id to use existing VPC"
  type        = string
  default     = ""
}

################################################################################
# DHCP
################################################################################
variable "dhcp" {
  description = "DHCP options"
  type = object({
    domain_name         = string
    domain_name_servers = list(string)
    ntp_servers         = list(string)
  })
  default = null
}

################################################################################
# Subnets
################################################################################
variable "intra_subnets" {
  description = "Map of intra subnets"
  type        = list(list(string))
  default     = []
}

variable "private_subnets" {
  description = "Map of private subnets"
  type        = list(list(string))
  default     = []
}

variable "public_subnets" {
  description = "Map of public subnets"
  type        = list(list(string))
  default     = []
}

################################################################################
# Routes
################################################################################
variable "create_intra_route_table" {
  description = "Controls if route tables should be created for intra subnets"
  type        = bool
  default     = true
}

variable "intra_routes" {
  description = "Map of routes for intra subnets"
  type = list(object({
    enabled            = bool,
    destination_prefix = string,
    next_hop_address   = string,
  }))
  default = []
}

variable "create_private_route_table" {
  description = "Controls if route tables should be created for private subnets"
  type        = bool
  default     = true
}

variable "private_routes" {
  description = "Map of routes for private subnets"
  type = list(object({
    enabled            = bool,
    destination_prefix = string,
    next_hop_address   = string,
  }))
  default = []
}

variable "private_routes_gateway" {
  description = <<EOL
Defines how private subnets connect to the internet.

Supported values:
- none         : No internet route will be added.
- nat_instance : Use a NAT instance for internet access (a route will be created if `create_nat_instance` is enabled).
- nat_gateway  : Use a NAT Gateway for internet access (a route will be created if `create_nat_gateway` is enabled).
EOL
  type        = string
  default     = "none"
  validation {
    condition     = contains(["none", "nat_instance", "nat_gateway"], var.private_routes_gateway)
    error_message = "private_routes_gateway must be one of: 'none', 'nat_instance', or 'nat_gateway'."
  }
}

variable "create_public_route_table" {
  description = "Controls if route tables should be created for public subnets"
  type        = bool
  default     = true
}

variable "public_routes" {
  description = "Map of routes for public subnets"
  type = list(object({
    enabled            = bool,
    destination_prefix = string,
    next_hop_address   = string,
  }))
  default = []
}


################################################################################
# NAT Gateway
################################################################################

variable "create_nat_gateway" {
  description = "If true, NAT Gateway will be created"
  type        = bool
  default     = false
}

variable "create_nat_instance" {
  description = "If true, NAT Instance will be created"
  type        = bool
  default     = false
}

variable "nat_instance_allow_ssh" {
  description = "If true, ssh access will be enabled at NAT Instances"
  type        = bool
  default     = false
}

variable "single_nat_instance" {
  description = "Should be true if you want to provision a single shared NAT Instance across all of your private networks"
  type        = bool
  default     = false
}

variable "nat_instance_image_id" {
  description = "The image_id to be used for the NAT instance. If left empty, a default image_id from `nat_instance_family` will be used."
  type        = string
  default     = ""
}

variable "nat_instance_family" {
  description = "VM family for NAT Instance. By default, it's Yandex official NAT Instance family: https://yandex.cloud/ru/marketplace/products/yc/nat-instance-ubuntu-22-04-lts"
  type        = string
  default     = "nat-instance-ubuntu-2204"
}

variable "nat_instance_vm" {
  description = "A set of default VM options for NAT Instances' VMs"
  type = object({
    platform_id               = string
    cores                     = number
    memory                    = number
    core_fraction             = number
    boot_disk_size            = number
    preemptible               = bool
    allow_stopping_for_update = bool
    generate_ssh_key          = bool
    ssh_user                  = string
    ssh_pubkey                = string
    enable_oslogin            = bool
  })
  default = {
    platform_id               = "standard-v3"
    cores                     = 2
    memory                    = 4
    core_fraction             = 100
    boot_disk_size            = 20
    preemptible               = false
    allow_stopping_for_update = false
    generate_ssh_key          = false
    ssh_user                  = "ubuntu"
    ssh_pubkey                = null
    enable_oslogin            = true
  }
}
