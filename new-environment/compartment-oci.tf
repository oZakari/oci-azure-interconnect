resource "oci_identity_compartment" "compartment" {
  provider       = oci.oci
  compartment_id = var.tenancy_ocid
  description    = "Compartment for automated Azure-OCI Interconnect latency testing."
  name           = lower(join("-", ["interconnect", var.peering_location, "cmpt"]))
  enable_delete  = true
}
