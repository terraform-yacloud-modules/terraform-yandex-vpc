#
# yandex cloud
#
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

#
# naming
#
variable "blank_name" {
  description = "Blank name which will be used for all resources"
  type        = string
}

variable "labels" {
  description = "A set of labels"
  type        = map(string)
  default     = {}
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "pub"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "prv"
}

#
# feature flags
#
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "create_nat" {
  description = "Controls if a nat gateway should be created"
  type        = bool
  default     = true
}

#
# dhcp
#
variable "dhcp" {
  description = "DCHP options"
  type = object({
    domain_name         = string
    domain_name_servers = list(string)
    ntp_servers         = list(string)
  })
  default = null
}

#
# subnets
#
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

#
# routes
#
variable "private_routes" {
  description = "Map of routes for private subnets"
  type = list(object({
    enabled            = bool,
    destination_prefix = string,
    next_hop_address   = string,
  }))
  default = []
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
