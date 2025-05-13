# Yandex Cloud VPC Terraform module

Terraform module which creates Yandex Cloud VPC resources.

## VPC Layout
This Terraform module provides the following types of networks:
* **intra**: If you need private subnets that should have no Internet routing (in the sense of [RFC1918 Category 1 subnets](https://tools.ietf.org/html/rfc1918)), `intra_subnets` should be specified. These networks does not have any routes to NAT. It also recommended to configure security group to restrict public inbound/outbound access at these networks.
* **private**: These networks have a route to NAT Gateway (NAT Instance). It means, that instances with private IPs will have access to the Internet via the NAT Gateway (NAT Instance). It also recommended to configure security group to restrict public inbound access at these networks.
* **public**: These networks do not have a route to NAT Gateway (NAT Instance). It means, that the access to/from the VM will be available only in case of attached public IP.


<details><summary><b>VPC layout with NAT Gateway</b></summary><br>
<img src="assets/vpc_nat_gateway.png" alt="vpc_nat_gateway">
</details>

<details><summary><b>VPC layout with NAT Instance</b></summary><br>
<img src="assets/vpc_nat_instance.png" alt="vpc_nat_instance">
</details>


### Single NAT Instance

If `single_nat_instance = true`, then all private subnets will route their Internet traffic through this single NAT gateway. The NAT gateway will be placed in the first public subnet in your `public_subnets` block.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-vpc/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nat_instance"></a> [nat\_instance](#module\_nat\_instance) | git::https://github.com/terraform-yacloud-modules/terraform-yandex-instance.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [yandex_compute_image.nat_instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_image) | resource |
| [yandex_vpc_address.nat_instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_address) | resource |
| [yandex_vpc_gateway.nat](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_gateway) | resource |
| [yandex_vpc_network.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_route_table.intra](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_route_table.private](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_route_table.public](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_security_group.nat_instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_security_group) | resource |
| [yandex_vpc_security_group_rule.nat_instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_security_group_rule) | resource |
| [yandex_vpc_security_group_rule.nat_instance_ssh](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_security_group_rule) | resource |
| [yandex_vpc_subnet.intra](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.private](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.public](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_network.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/vpc_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | A list of availability zones names or ids in the region | `list(string)` | `[]` | no |
| <a name="input_blank_name"></a> [blank\_name](#input\_blank\_name) | Blank name which will be used for all resources | `string` | n/a | yes |
| <a name="input_create_intra_route_table"></a> [create\_intra\_route\_table](#input\_create\_intra\_route\_table) | Controls if route tables should be created for intra subnets | `bool` | `true` | no |
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | If true, NAT Gateway will be created | `bool` | `false` | no |
| <a name="input_create_nat_instance"></a> [create\_nat\_instance](#input\_create\_nat\_instance) | If true, NAT Instance will be created | `bool` | `false` | no |
| <a name="input_create_private_route_table"></a> [create\_private\_route\_table](#input\_create\_private\_route\_table) | Controls if route tables should be created for private subnets | `bool` | `true` | no |
| <a name="input_create_public_route_table"></a> [create\_public\_route\_table](#input\_create\_public\_route\_table) | Controls if route tables should be created for public subnets | `bool` | `true` | no |
| <a name="input_create_subnets"></a> [create\_subnets](#input\_create\_subnets) | Controls if subnets should be created | `bool` | `true` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Controls if VPC should be created | `bool` | `true` | no |
| <a name="input_dhcp"></a> [dhcp](#input\_dhcp) | DHCP options | <pre>object({<br/>    domain_name         = string<br/>    domain_name_servers = list(string)<br/>    ntp_servers         = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID | `string` | `null` | no |
| <a name="input_intra_routes"></a> [intra\_routes](#input\_intra\_routes) | Map of routes for intra subnets | <pre>list(object({<br/>    enabled            = bool,<br/>    destination_prefix = string,<br/>    next_hop_address   = string,<br/>  }))</pre> | `[]` | no |
| <a name="input_intra_subnet_suffix"></a> [intra\_subnet\_suffix](#input\_intra\_subnet\_suffix) | Suffix to append to intra subnets name | `string` | `"intra"` | no |
| <a name="input_intra_subnets"></a> [intra\_subnets](#input\_intra\_subnets) | Map of intra subnets | `list(list(string))` | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of labels | `map(string)` | `{}` | no |
| <a name="input_nat_instance_allow_ssh"></a> [nat\_instance\_allow\_ssh](#input\_nat\_instance\_allow\_ssh) | If true, ssh access will be enabled at NAT Instances | `bool` | `false` | no |
| <a name="input_nat_instance_family"></a> [nat\_instance\_family](#input\_nat\_instance\_family) | VM family for NAT Instance. By default, it's Yandex official NAT Instance family: https://yandex.cloud/ru/marketplace/products/yc/nat-instance-ubuntu-22-04-lts | `string` | `"nat-instance-ubuntu-2204"` | no |
| <a name="input_nat_instance_image_id"></a> [nat\_instance\_image\_id](#input\_nat\_instance\_image\_id) | The image\_id to be used for the NAT instance. If left empty, a default image\_id from `nat_instance_family` will be used. | `string` | `""` | no |
| <a name="input_nat_instance_vm"></a> [nat\_instance\_vm](#input\_nat\_instance\_vm) | A set of default VM options for NAT Instances' VMs | <pre>object({<br/>    platform_id               = string<br/>    cores                     = number<br/>    memory                    = number<br/>    core_fraction             = number<br/>    boot_disk_size            = number<br/>    preemptible               = bool<br/>    allow_stopping_for_update = bool<br/>    generate_ssh_key          = bool<br/>    ssh_user                  = string<br/>    ssh_pubkey                = string<br/>    enable_oslogin            = bool<br/>  })</pre> | <pre>{<br/>  "allow_stopping_for_update": false,<br/>  "boot_disk_size": 20,<br/>  "core_fraction": 100,<br/>  "cores": 2,<br/>  "enable_oslogin": true,<br/>  "generate_ssh_key": false,<br/>  "memory": 4,<br/>  "platform_id": "standard-v3",<br/>  "preemptible": false,<br/>  "ssh_pubkey": null,<br/>  "ssh_user": "ubuntu"<br/>}</pre> | no |
| <a name="input_private_routes"></a> [private\_routes](#input\_private\_routes) | Map of routes for private subnets | <pre>list(object({<br/>    enabled            = bool,<br/>    destination_prefix = string,<br/>    next_hop_address   = string,<br/>  }))</pre> | `[]` | no |
| <a name="input_private_routes_gateway"></a> [private\_routes\_gateway](#input\_private\_routes\_gateway) | Defines how private subnets connect to the internet.<br/><br/>Supported values:<br/>- none         : No internet route will be added.<br/>- nat\_instance : Use a NAT instance for internet access (a route will be created if `create_nat_instance` is enabled).<br/>- nat\_gateway  : Use a NAT Gateway for internet access (a route will be created if `create_nat_gateway` is enabled). | `string` | `"none"` | no |
| <a name="input_private_subnet_suffix"></a> [private\_subnet\_suffix](#input\_private\_subnet\_suffix) | Suffix to append to private subnets name | `string` | `"prv"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Map of private subnets | `list(list(string))` | `[]` | no |
| <a name="input_public_routes"></a> [public\_routes](#input\_public\_routes) | Map of routes for public subnets | <pre>list(object({<br/>    enabled            = bool,<br/>    destination_prefix = string,<br/>    next_hop_address   = string,<br/>  }))</pre> | `[]` | no |
| <a name="input_public_subnet_suffix"></a> [public\_subnet\_suffix](#input\_public\_subnet\_suffix) | Suffix to append to public subnets name | `string` | `"pub"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Map of public subnets | `list(list(string))` | `[]` | no |
| <a name="input_single_nat_instance"></a> [single\_nat\_instance](#input\_single\_nat\_instance) | Should be true if you want to provision a single shared NAT Instance across all of your private networks | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | If create\_vpc set to false you may provide vpc\_id to use existing VPC | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_intra_rt"></a> [intra\_rt](#output\_intra\_rt) | Intra route tables info |
| <a name="output_intra_subnets"></a> [intra\_subnets](#output\_intra\_subnets) | Raw information about intra subnets |
| <a name="output_intra_subnets_cidr_blocks"></a> [intra\_subnets\_cidr\_blocks](#output\_intra\_subnets\_cidr\_blocks) | List of intra subnets cidr\_blocks |
| <a name="output_intra_subnets_ids"></a> [intra\_subnets\_ids](#output\_intra\_subnets\_ids) | List of intra subnets IDs |
| <a name="output_intra_subnets_ipv6_cidr_blocks"></a> [intra\_subnets\_ipv6\_cidr\_blocks](#output\_intra\_subnets\_ipv6\_cidr\_blocks) | List of intra subnets IPv6 cidr\_blocks |
| <a name="output_nat_gw_id"></a> [nat\_gw\_id](#output\_nat\_gw\_id) | NAT |
| <a name="output_nat_id"></a> [nat\_id](#output\_nat\_id) | NAT Gateway ID |
| <a name="output_nat_instance_ip"></a> [nat\_instance\_ip](#output\_nat\_instance\_ip) | n/a |
| <a name="output_nat_instance_sg_id"></a> [nat\_instance\_sg\_id](#output\_nat\_instance\_sg\_id) | n/a |
| <a name="output_private_rt"></a> [private\_rt](#output\_private\_rt) | Private route tables info |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | Raw information about private subnets |
| <a name="output_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#output\_private\_subnets\_cidr\_blocks) | List of private subnets cidr\_blocks |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | List of private subnets IDs |
| <a name="output_private_subnets_ipv6_cidr_blocks"></a> [private\_subnets\_ipv6\_cidr\_blocks](#output\_private\_subnets\_ipv6\_cidr\_blocks) | List of private subnets IPv6 cidr\_blocks |
| <a name="output_public_rt"></a> [public\_rt](#output\_public\_rt) | Public route tables info |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | Raw information about public subnets |
| <a name="output_public_subnets_cidr_blocks"></a> [public\_subnets\_cidr\_blocks](#output\_public\_subnets\_cidr\_blocks) | List of public subnets cidr\_blocks |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | List of public subnets IDs |
| <a name="output_public_subnets_ipv6_cidr_blocks"></a> [public\_subnets\_ipv6\_cidr\_blocks](#output\_public\_subnets\_ipv6\_cidr\_blocks) | List of public subnets IPv6 cidr\_blocks |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | VPC Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-vpc/blob/main/LICENSE).
