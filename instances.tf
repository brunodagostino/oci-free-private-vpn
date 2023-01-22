resource "oci_core_instance" "vpn_instance" {
  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Management Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Custom Logs Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }
  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.vpn_compartment.id
  create_vnic_details {
    assign_private_dns_record = var.instance_config.assign_private_dns_record
    assign_public_ip          = var.instance_config.assign_public_ip
    subnet_id                 = oci_core_subnet.vpn_subnet.id
  }
  display_name = var.instance_config.display_name
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
  metadata = {
    "ssh_authorized_keys" = var.ssh_authorized_keys_instance
  }
  shape = var.instance_config.shape
  source_details {
    source_id   = var.instance_config.source_id
    source_type = var.instance_config.source_type
  }
  depends_on = [
    oci_core_app_catalog_subscription.oci_core_app_catalog_subscription
  ]
}

resource "oci_core_app_catalog_subscription" "oci_core_app_catalog_subscription" {
  compartment_id           = oci_identity_compartment.vpn_compartment.id
  eula_link                = oci_core_app_catalog_listing_resource_version_agreement.oci_core_app_catalog_listing_resource_version_agreement.eula_link
  listing_id               = oci_core_app_catalog_listing_resource_version_agreement.oci_core_app_catalog_listing_resource_version_agreement.listing_id
  listing_resource_version = "AS_2.8.3"
  oracle_terms_of_use_link = oci_core_app_catalog_listing_resource_version_agreement.oci_core_app_catalog_listing_resource_version_agreement.oracle_terms_of_use_link
  signature                = oci_core_app_catalog_listing_resource_version_agreement.oci_core_app_catalog_listing_resource_version_agreement.signature
  time_retrieved           = oci_core_app_catalog_listing_resource_version_agreement.oci_core_app_catalog_listing_resource_version_agreement.time_retrieved
}

resource "oci_core_app_catalog_listing_resource_version_agreement" "oci_core_app_catalog_listing_resource_version_agreement" {
  listing_id               = "ocid1.appcataloglisting.oc1..aaaaaaaafbgwdxg5j6jnyfhbcxvd62iabcraaf6bwu2u2nhrddztrrle66lq"
  listing_resource_version = "AS_2.8.3"
}