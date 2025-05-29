# Private endpoint resource for Yandex Object Storage
# Creates a secure connection to Object Storage without going through the public internet
# This is useful for security-sensitive applications or to reduce data transfer costs
resource "yandex_vpc_private_endpoint" "private_endpoint" {
  count = var.private_endpoint.enable == true ? 1 : 0

  name        = var.private_endpoint.name == null ? "${var.blank_name}-private-endpoint" : var.private_endpoint.name
  description = var.private_endpoint.description

  # Apply labels from the module or merge with endpoint-specific labels if provided
  labels = var.private_endpoint.labels == null ? var.labels : merge(var.labels, var.private_endpoint.labels)

  network_id = local.vpc_id

  # Configure this private endpoint for Object Storage service
  object_storage {}

  # DNS configuration options for the private endpoint
  # When private_dns_records_enabled = true, DNS entries are created for accessing Object Storage
  # through the private endpoint instead of public endpoints
  dns_options {
    private_dns_records_enabled = var.private_endpoint.private_dns_records_enabled
  }

  # Configuration option 1: Using subnet_id and optional address
  # This approach selects a subnet and optionally specifies an IP address within that subnet
  dynamic "endpoint_address" {
    for_each = var.private_endpoint.address_id == null && length(var.private_subnets) > 0 ? [1] : []
    content {
      # Logic for selecting the subnet:
      # - If subnet_v4_cidr_block is null, use the first private subnet
      # - Otherwise, find the subnet matching the specified CIDR block
      subnet_id = var.private_endpoint.subnet_v4_cidr_block == null ? yandex_vpc_subnet.private[0].id : (
        contains(flatten(var.private_subnets), var.private_endpoint.subnet_v4_cidr_block) ?
        yandex_vpc_subnet.private[index(flatten(var.private_subnets), var.private_endpoint.subnet_v4_cidr_block)].id :
        yandex_vpc_subnet.private[0].id
      )

      # Optional: Specify a particular IP address within the subnet
      # If not provided, an available IP will be automatically assigned
      address = var.private_endpoint.address
    }
  }

  # Configuration option 2: Using an existing address_id
  # This approach uses a pre-created address resource
  dynamic "endpoint_address" {
    for_each = var.private_endpoint.address_id != null ? [1] : []
    content {
      # Reference to a yandex_vpc_address resource ID
      address_id = var.private_endpoint.address_id
    }
  }
}
