# ------ Create OCI VCN 
resource "oci_core_vcn" "interconnect_vcn" {
  provider       = oci.oci
  cidr_block     = var.interconnect_vcn_cidr_block
  compartment_id = oci_identity_compartment.compartment.id
  display_name   = "InterConnect VCN"
  dns_label      = "interconnectvcn"
}

# ------ Create Public Compute Subnet
resource "oci_core_subnet" "compute_subnet" {
  provider            = oci.oci
  count               = length(data.oci_identity_availability_domains.ads.availability_domains)
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[count.index], "name")
  cidr_block          = cidrsubnet(var.oci_compute_subnet, 3, count.index)
  display_name        = join("-", [var.oci_compute_subnet_display_name, "domain", count.index + 1])
  dns_label           = join("", [var.oci_compute_subnet_dns_label, count.index + 1])
  security_list_ids   = [oci_core_security_list.security_policies_azure.id]
  compartment_id      = oci_identity_compartment.compartment.id
  vcn_id              = oci_core_vcn.interconnect_vcn.id
  route_table_id      = oci_core_route_table.compute_route_table.id
  dhcp_options_id     = oci_core_vcn.interconnect_vcn.default_dhcp_options_id
}

# ------ Create OCI VCN Internet Gateway
resource "oci_core_internet_gateway" "internet_gateway" {
  provider       = oci.oci
  compartment_id = oci_identity_compartment.compartment.id
  display_name   = var.internet_gateway_name
  vcn_id         = oci_core_vcn.interconnect_vcn.id
}

# ------ Create OCI Compute Route Table
resource "oci_core_route_table" "compute_route_table" {
  provider       = oci.oci
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.interconnect_vcn.id
  display_name   = var.compute_route_table_display_name

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
  route_rules {
    destination       = azurerm_virtual_network.virtual_network.address_space[0]
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.drg_azure.id
  }
}

# ------ Create DRG on OCI 
resource "oci_core_drg" "drg_azure" {
  provider       = oci.oci
  compartment_id = oci_identity_compartment.compartment.id
}

# ------ Create Security Policies on Azure
resource "oci_core_security_list" "security_policies_azure" {
  provider       = oci.oci
  compartment_id = oci_identity_compartment.compartment.id
  display_name   = var.security_policy_name
  vcn_id         = oci_core_vcn.interconnect_vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "all"
    source   = azurerm_virtual_network.virtual_network.address_space[0]
  }

  ingress_security_rules {
    protocol = "all"
    source   = "0.0.0.0/0"
  }

}

# ------ Create DRG Attachment on Azure
resource "oci_core_drg_attachment" "drg_attachment" {
  provider = oci.oci
  drg_id   = oci_core_drg.drg_azure.id
  vcn_id   = oci_core_vcn.interconnect_vcn.id
}
