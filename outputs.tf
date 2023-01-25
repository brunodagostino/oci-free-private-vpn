# Output the "list" of all availability domains.
output "all_availability_domains_in_your_tenancy" {
  description = "All the availability domains in your tenancy"
  value       = data.oci_identity_availability_domains.ads.availability_domains
}

# Outputs for compartment
output "compartment_name" {
  value = oci_identity_compartment.vpn_compartment.name
}

output "compartment_OCID" {
  value = oci_identity_compartment.vpn_compartment.id
}

# Outputs for the vcn module
output "vcn_id" {
  description = "OCID of the VCN that is created"
  value       = module.vcn.vcn_id
}
output "id_for_route_table_that_includes_the_internet_gateway" {
  description = "OCID of the internet-route table. This route table has an internet gateway to be used for public subnets"
  value       = module.vcn.ig_route_id
}
output "nat_gateway_id" {
  description = "OCID for NAT gateway"
  value       = module.vcn.nat_gateway_id
}
output "id_for_for_route_table_that_includes_the_nat_gateway" {
  description = "OCID of the nat-route table - This route table has a nat gateway to be used for private subnets. This route table also has a service gateway."
  value       = module.vcn.nat_route_id
}


# Outputs for vpn subnet
output "vpn_subnet_name" {
  value = oci_core_subnet.vpn_subnet.display_name
}
output "vpn_subnet_OCID" {
  value = oci_core_subnet.vpn_subnet.id
}

# Outputs for security list
output "security_list_name" {
  value = oci_core_security_list.security_list.display_name
}
output "security_list_OCID" {
  value = oci_core_security_list.security_list.id
}