# Yandex Cloud VPC Terraform module

Terraform module which creates Yandex Cloud VPC resources.

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

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_gateway.nat](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_gateway) | resource |
| [yandex_vpc_network.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_route_table.private](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_route_table.public](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_subnet.private](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.public](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | A list of availability zones names or ids in the region | `list(string)` | `[]` | no |
| <a name="input_blank_name"></a> [blank\_name](#input\_blank\_name) | Blank name which will be used for all resources | `string` | n/a | yes |
| <a name="input_create_nat"></a> [create\_nat](#input\_create\_nat) | Controls if a nat gateway should be created | `bool` | `true` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Controls if VPC should be created (it affects almost all resources) | `bool` | `true` | no |
| <a name="input_dhcp"></a> [dhcp](#input\_dhcp) | DCHP options | <pre>object({<br>    domain_name         = string<br>    domain_name_servers = list(string)<br>    ntp_servers         = list(string)<br>  })</pre> | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of labels | `map(string)` | `{}` | no |
| <a name="input_private_routes"></a> [private\_routes](#input\_private\_routes) | Map of routes for private subnets | <pre>list(object({<br>    enabled            = bool,<br>    destination_prefix = string,<br>    next_hop_address   = string,<br>  }))</pre> | `[]` | no |
| <a name="input_private_subnet_suffix"></a> [private\_subnet\_suffix](#input\_private\_subnet\_suffix) | Suffix to append to private subnets name | `string` | `"prv"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Map of private subnets | `list(list(string))` | `[]` | no |
| <a name="input_public_routes"></a> [public\_routes](#input\_public\_routes) | Map of routes for public subnets | <pre>list(object({<br>    enabled            = bool,<br>    destination_prefix = string,<br>    next_hop_address   = string,<br>  }))</pre> | `[]` | no |
| <a name="input_public_subnet_suffix"></a> [public\_subnet\_suffix](#input\_public\_subnet\_suffix) | Suffix to append to public subnets name | `string` | `"pub"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Map of public subnets | `list(list(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_id"></a> [nat\_id](#output\_nat\_id) | NAT Gateway ID |
| <a name="output_private_rt"></a> [private\_rt](#output\_private\_rt) | Private route table info |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | Private subnets info |
| <a name="output_public_rt"></a> [public\_rt](#output\_public\_rt) | Public route table info |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | Public subnets info |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | VPC Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-vpc/blob/main/LICENSE).
