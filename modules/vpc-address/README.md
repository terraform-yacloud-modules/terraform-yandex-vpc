# Yandex.Cloud VPC Address Terraform sub-module

Terraform sub-module which creates VPC address resources on Yandex.Cloud.

## Usage

```hcl

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | > 0.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | > 0.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_address.addr](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_address) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID where the resources will be created | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Set of key/value label pairs to assign. | `map(string)` | <pre>{<br>  "created_by": "terraform yc module"<br>}</pre> | no |
| <a name="input_vpc_address"></a> [vpc\_address](#input\_vpc\_address) | "Describe your private subnet preferences. For VMs without public IPs but with or without NAT gateway. For Multi-Folder VPC add folder\_id to subnet object"<br>  addresses = [<br>  {<br>    "name" : "vm",<br>    "description" : "vm static address",<br>    "zone" : "ru-central1-a",<br>    "ddos\_protection\_provider" : "true"<br>  },<br>  {<br>    "v4\_cidr\_blocks" : ["10.231.0.0/16"],<br>    "zone" : "ru-central1-b"<br>    "folder\_id" : "xxxxxxx" # For Multi-Folder VPC<br>  },<br>  ] | `any` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
