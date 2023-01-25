# Source from https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/
module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"

  # Required Inputs
  compartment_id = oci_identity_compartment.vpn_compartment.id
  region         = var.region

  # internet_gateway_route_rules = var.vcn_config.internet_gateway_route_rules
  # local_peering_gateways       = var.vcn_config.local_peering_gateways
  # nat_gateway_route_rules      = var.vcn_config.nat_gateway_route_rules

  # Optional Inputs
  vcn_name      = var.labels.vcn_name
  vcn_dns_label = var.labels.vcn_dns_label
  vcn_cidrs     = var.vcn_cidrs

  create_internet_gateway = var.vcn_config.create_internet_gateway
  create_nat_gateway      = var.vcn_config.create_nat_gateway
  create_service_gateway  = var.vcn_config.create_service_gateway
}

# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet
resource "oci_core_subnet" "vpn_subnet" {
  # Required
  compartment_id = oci_identity_compartment.vpn_compartment.id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = var.subnet_config.cidr_block

  # Optional
  route_table_id    = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.security_list.id]
  display_name      = var.labels.subnet_display_name
}

resource "oci_core_security_list" "security_list" {
  # Required
  compartment_id = oci_identity_compartment.vpn_compartment.id
  vcn_id         = module.vcn.vcn_id

  # Optional
  display_name = var.security_list_config.display_name

  ingress_security_rules {
    #Required
    protocol = var.security_list_config.tcp_protocol
    source   = var.security_list_config.source

    description = var.security_list_config.tcp_description

    source_type = var.security_list_config.source_type

    tcp_options {
      min = var.security_list_config.tcp_min
      max = var.security_list_config.tcp_max
    }
  }

  ingress_security_rules {
    #Required
    protocol = var.security_list_config.udp_protocol
    source   = var.security_list_config.source

    description = var.security_list_config.udp_description

    source_type = var.security_list_config.source_type

    udp_options {
      min = var.security_list_config.udp_min
      max = var.security_list_config.udp_max
    }
  }

  ingress_security_rules {
    #Required
    protocol = var.security_list_config.tcp_protocol
    source   = var.security_list_config.source

    description = var.security_list_config.ssh_description

    source_type = var.security_list_config.source_type

    tcp_options {
      min = 22
      max = 22
    }
  }

  egress_security_rules {
    # Required
    protocol    = var.security_list_config.tcp_protocol
    destination = var.security_list_config.destination

    description = var.security_list_config.tcp_description

    destination_type = var.security_list_config.destination_type
  }
}