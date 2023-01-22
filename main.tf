# ------ Initialize Oracle Terraform provider
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}


# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains
# <tenancy-ocid> is the compartment OCID for the root compartment.
# Use <tenancy-ocid> for the compartment OCID.
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_identity_compartment" "vpn_compartment" {
  # Required
  compartment_id = var.tenancy_ocid
  description    = var.compartment_config.description
  name           = var.compartment_config.name
}