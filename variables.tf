############################
#  OCI Tenancy Credentials #
############################
variable "tenancy_ocid" {
  description = "User Tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "User OCID"
  type        = string
}

variable "fingerprint" {
  description = "User Private Key Fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "User Private Key Path"
  type        = string
}

variable "compartment_ocid" {
  description = "User Compartment OCID"
  type        = string
}

variable "region" {
  description = "User Region Value"
  type        = string
}


variable "labels" {
  description = "A map of labels to apply to contained resources."
  default = {
    vcn_name            = "vpn_vcn"
    vcn_dns_label       = "vpnvcn"
    subnet_display_name = "vpn_subnet"
  }
  type = map(string)
}

variable "compartment_config" {
  description = "A map of configs to apply to the compartment."
  default = {
    description = "Compartment for VPN resources."
    name        = "vpn_compartment"
  }
  type = map(string)
}

variable "vcn_config" {
  description = "A map of configs to apply to the VCN."
  default = {
    internet_gateway_route_rules = null
    local_peering_gateways       = null
    nat_gateway_route_rules      = null
    create_internet_gateway      = true
    create_nat_gateway           = false
    create_service_gateway       = false
  }
  type = map(string)
}

variable "vcn_cidrs" {
  description = "List of VCN CIDRS."
  default     = ["10.0.0.0/16"]
  type        = list(string)
}

variable "subnet_config" {
  description = "A map of configs to apply to the subnet."
  default = {
    cidr_block = "10.0.0.0/24"
  }
  type = map(string)
}

variable "instance_config" {
  description = "A map of configs to apply to the instance."
  default = {
    assign_private_dns_record = "true"
    assign_public_ip          = "true"
    display_name              = "vpn_instance"
    shape                     = "VM.Standard.E2.1.Micro"
    source_id                 = "ocid1.image.oc1..aaaaaaaa4ozqggnywlp3e3wzvu5x3aoohkt6cwm2pumgpn2tlzroj756azma"
    source_type               = "image"
  }
  type = map(string)
}

variable "ssh_authorized_keys_instance" {
  description = "SSH key for the instance."
  type        = string
}

variable "security_list_config" {
  description = "A map of configs to apply to the security list."
  default = {
    display_name     = "security_list_for_subnet"
    tcp_protocol     = "6"
    udp_protocol     = "17"
    source           = "0.0.0.0/0"
    tcp_description  = "OpenVPN"
    udp_description  = "OpenVPN VPN tunnel"
    ssh_description  = "SSH tunnel to OpenVPN"
    source_type      = "CIDR_BLOCK"
    tcp_min          = "443"
    tcp_max          = "943"
    udp_min          = "1194"
    udp_max          = "1194"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
  type = map(string)
}