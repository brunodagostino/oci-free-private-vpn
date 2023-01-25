# oci-free-private-vpn
Run your own VPN on an "always free" instance in the Oracle Cloud.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.104.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vcn"></a> [vcn](#module\_vcn) | oracle-terraform-modules/vcn/oci | 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [oci_core_app_catalog_listing_resource_version_agreement.oci_core_app_catalog_listing_resource_version_agreement](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_app_catalog_listing_resource_version_agreement) | resource |
| [oci_core_app_catalog_subscription.oci_core_app_catalog_subscription](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_app_catalog_subscription) | resource |
| [oci_core_instance.vpn_instance](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance) | resource |
| [oci_core_security_list.security_list](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_security_list) | resource |
| [oci_core_subnet.vpn_subnet](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet) | resource |
| [oci_identity_compartment.vpn_compartment](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_availability_domains.ads](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_config"></a> [compartment\_config](#input\_compartment\_config) | A map of configs to apply to the compartment. | `map(string)` | <pre>{<br>  "description": "Compartment for VPN resources.",<br>  "name": "vpn_compartment"<br>}</pre> | no |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | User Compartment OCID | `string` | n/a | yes |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | User Private Key Fingerprint | `string` | n/a | yes |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | A map of configs to apply to the instance. | `map(string)` | <pre>{<br>  "assign_private_dns_record": "true",<br>  "assign_public_ip": "true",<br>  "display_name": "vpn_instance",<br>  "shape": "VM.Standard.E2.1.Micro",<br>  "source_id": "ocid1.image.oc1..aaaaaaaa4ozqggnywlp3e3wzvu5x3aoohkt6cwm2pumgpn2tlzroj756azma",<br>  "source_type": "image"<br>}</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to apply to contained resources. | `map(string)` | <pre>{<br>  "subnet_display_name": "vpn_subnet",<br>  "vcn_dns_label": "vpnvcn",<br>  "vcn_name": "vpn_vcn"<br>}</pre> | no |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | User Private Key Path | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | User Region Value | `string` | n/a | yes |
| <a name="input_security_list_config"></a> [security\_list\_config](#input\_security\_list\_config) | A map of configs to apply to the security list. | `map(string)` | <pre>{<br>  "destination": "0.0.0.0/0",<br>  "destination_type": "CIDR_BLOCK",<br>  "display_name": "security_list_for_subnet",<br>  "source": "0.0.0.0/0",<br>  "source_type": "CIDR_BLOCK",<br>  "ssh_description": "SSH tunnel to OpenVPN",<br>  "tcp_description": "OpenVPN",<br>  "tcp_max": "943",<br>  "tcp_min": "443",<br>  "tcp_protocol": "6",<br>  "udp_description": "OpenVPN VPN tunnel",<br>  "udp_max": "1194",<br>  "udp_min": "1194",<br>  "udp_protocol": "17"<br>}</pre> | no |
| <a name="input_ssh_authorized_keys_instance"></a> [ssh\_authorized\_keys\_instance](#input\_ssh\_authorized\_keys\_instance) | SSH key for the instance. | `string` | n/a | yes |
| <a name="input_subnet_config"></a> [subnet\_config](#input\_subnet\_config) | A map of configs to apply to the subnet. | `map(string)` | <pre>{<br>  "cidr_block": "10.0.0.0/24"<br>}</pre> | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | User Tenancy OCID | `string` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | User OCID | `string` | n/a | yes |
| <a name="input_vcn_cidrs"></a> [vcn\_cidrs](#input\_vcn\_cidrs) | List of VCN CIDRS. | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_vcn_config"></a> [vcn\_config](#input\_vcn\_config) | A map of configs to apply to the VCN. | `map(string)` | <pre>{<br>  "create_internet_gateway": true,<br>  "create_nat_gateway": false,<br>  "create_service_gateway": false,<br>  "internet_gateway_route_rules": null,<br>  "local_peering_gateways": null,<br>  "nat_gateway_route_rules": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_availability_domains_in_your_tenancy"></a> [all\_availability\_domains\_in\_your\_tenancy](#output\_all\_availability\_domains\_in\_your\_tenancy) | All the availability domains in your tenancy |
| <a name="output_compartment_OCID"></a> [compartment\_OCID](#output\_compartment\_OCID) | n/a |
| <a name="output_compartment_name"></a> [compartment\_name](#output\_compartment\_name) | Outputs for compartment |
| <a name="output_id_for_for_route_table_that_includes_the_nat_gateway"></a> [id\_for\_for\_route\_table\_that\_includes\_the\_nat\_gateway](#output\_id\_for\_for\_route\_table\_that\_includes\_the\_nat\_gateway) | OCID of the nat-route table - This route table has a nat gateway to be used for private subnets. This route table also has a service gateway. |
| <a name="output_id_for_route_table_that_includes_the_internet_gateway"></a> [id\_for\_route\_table\_that\_includes\_the\_internet\_gateway](#output\_id\_for\_route\_table\_that\_includes\_the\_internet\_gateway) | OCID of the internet-route table. This route table has an internet gateway to be used for public subnets |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | OCID for NAT gateway |
| <a name="output_security_list_OCID"></a> [security\_list\_OCID](#output\_security\_list\_OCID) | n/a |
| <a name="output_security_list_name"></a> [security\_list\_name](#output\_security\_list\_name) | Outputs for security list |
| <a name="output_vcn_id"></a> [vcn\_id](#output\_vcn\_id) | OCID of the VCN that is created |
| <a name="output_vpn_subnet_OCID"></a> [vpn\_subnet\_OCID](#output\_vpn\_subnet\_OCID) | n/a |
| <a name="output_vpn_subnet_name"></a> [vpn\_subnet\_name](#output\_vpn\_subnet\_name) | Outputs for vpn subnet |
<!-- END_TF_DOCS -->