############################
# Azure Region Credentials #
############################

variable "azure_region" {
  description = "Azure Region Name"
}

variable "peering_location" {
  description = "Azure Peering Location Where OCI providor exists"
}

variable "bandwidth" {
  description = "Azure ExpressRoute Circuit Bandwidth"
}

############################
# Personal IP #
############################
variable "personalip_address_space" {
  description = "Address space containing your personal IP address"
}

############################
#  OCI Tenancy Credentials #
############################

variable "tenancy_ocid" {
  description = "User Tenancy OCID"
}

variable "compartment_ocid" {
  description = "User Compartment OCID"
}

variable "region" {
  description = "User Region Value"
}

variable "user_ocid" {
  description = "User OCID"
}

variable "fingerprint" {
  description = "User Private Key Fingerprint"
}

variable "private_key_path" {
  description = "User Private Key Path"
}

variable "private_key_password" {
  description = "Passphrase used during private key creation"
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "SSH Public Key string value"
}

############################
# Instance Credentials #
############################

variable "InstanceShape" {
  description = "Instance Default Size"
  default     = "VM.Standard.A1.Flex"
}

variable "InstanceImageOCID" {
  description = "Instance Image OCID Associated with Each Region"
  type        = map(any)
  default = {
    // See https://docs.oracle.com/en-us/iaas/images/image/9801d535-f7a9-4051-9fbe-2df35ce229e0/
    // Johannesburg and Singapore using Ubuntu images
    us-phoenix-1      = "ocid1.image.oc1.phx.aaaaaaaafa256ipe7v5c6pmiqzy553g72tmow4wvwfmkpp6sunjyo77em4ga"
    us-sanjose-1      = "ocid1.image.oc1.us-sanjose-1.aaaaaaaaxl7w4jnusqvmt6ic5ppz7bck66wrtcxm7afb4b2bem7fnzha7lma"
    us-ashburn-1      = "ocid1.image.oc1.iad.aaaaaaaabr2p2s6fnh5kf4u77y7se2kmaieuzjhqfmjwquw3csgq32i6kx5a"
    a-toronto-1       = "ocid1.image.oc1.ca-toronto-1.aaaaaaaakgl42zrzi4kpd7k2toyltq5eqgtpevzscpsjaa75zxqxzxq4haeq"
    sa-vinhedo-1      = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaa3l23v2zmzygmyggzmqr6uxxikq2wpazn5ymxg6o4pjsewdplh3cq"
    eu-frankfurt-1    = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaat5wpayf23ew5m2oilaq3sg6mnclfy62ukwb3br3z6jlmsha4wxnq"
    eu-amsterdam-1    = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaa526auzq66wvw4m2f4l2jhvlluvjc6njpnzqjtuiq23ghb3u5ymoa"
    uk-london-1       = "ocid1.image.oc1.uk-london-1.aaaaaaaauayefkbfjhmi7zlbc7wcstu77amzfj6tjllbpbakk6sumdiqipea"
    af-johannesburg-1 = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaab7yk3c6tq2w4a2qnpyjiwtporcrjpfax2sfnf35enlrafj4r3e3a"
    ap-osaka-1        = "ocid1.image.oc1.ap-osaka-1.aaaaaaaaipqswv56ouy6jadb3c3jqacyjykq2xunvnfnqzsci72cwjd6s2la"
    ap-seoul-1        = "ocid1.image.oc1.ap-seoul-1.aaaaaaaamcdp3k2q2r3n7ehqerumsveqpfldxdfd2l6jhzb63aclo62hxt2a"
    ap-singapore-1    = "ocid1.image.oc1.ap-singapore-1.aaaaaaaarhngxlpmasxc7ieavyqyzgtf7tpz75iavxlu6yfhljqyqdnxa6ga"
  }
}

variable "vm_pw" {
  description = "PW for your virtual machine"
  sensitive   = true
}

############################
# Azure Variables  #
############################

variable "azure_resource_group_name" {
  description = "Azure Resource Group Name"
  default     = "azure_oci_test_resources"
}

variable "azure_vnet_address" {
  description = "Azure VNET Address Range"
  default     = "10.12.0.0/16"
}

variable "azure_gateway_subnet" {
  description = "Azure Gateway Subnet Address Range"
  type        = list(string)
  default     = ["10.12.1.0/24"]
}

variable "azure_compute_subnet" {
  description = "Azure Compute Subnet Address Range"
  type        = list(string)
  default     = ["10.12.2.0/24"]
}

variable "azure_compute_vnic_name" {
  description = "Azure Compute VM NIC Name"
  default     = "compute-vm-nic"
}

variable "azure_compute_machine_name" {
  description = "Azure Compute VM Name"
  default     = "azure-compute"
}

variable "azure_express_circuit_name" {
  description = "Azure Express Route circuit Name"
  default     = "azure_express_circuit"
}

variable "azure_virtual_network_name" {
  description = "Azure Virtual Network Name"
  default     = "oci_network"
}

variable "gateway_subnet_name" {
  description = "Azure Gateway Subnet Name"
  default     = "GatewaySubnet"
}

variable "compute_subnet_name" {
  description = "Azure Compte Subnet Name for VMs"
  default     = "ComputeSubnet"
}

variable "gateway_public_ip_name" {
  description = "Azure Gateway Public IP Name"
  default     = "GatewayPublicIP"
}

variable "azure_vm_public_ip_name" {
  description = "Azure VM Public IP Name"
  default     = "AzureVMPublicIP"
}

variable "azure_route_table_name" {
  description = "Azure Route Table Name"
  default     = "azure_route_table"
}

variable "azure_nsg_name" {
  description = "Azure Network Security Group Name"
  default     = "azure-oci-nsg"
}

variable "virtual_network_gateway_name" {
  description = "Azure Network Gateway Name"
  default     = "InterConnectVNETGateway"
}

variable "virtual_network_gateway_connection_name" {
  description = "Azure Network Gateway Connection Name"
  default     = "azure_to_oci"
}


###########################################
#  Oracle Cloud Infrastructure Variables  #
###########################################

variable "interconnect_vcn_cidr_block" {
  description = "Interconnect VCN CIDR"
  default     = "10.1.0.0/16"
}

variable "oci_compute_subnet_display_name" {
  description = "Compute Subnet Name"
  default     = "ComputeSubnet"
}

variable "oci_compute_subnet" {
  description = "Compute Subnet CIDR"
  default     = "10.1.1.0/24"
}

variable "oci_compute_subnet_dns_label" {
  description = "Compute Subnet DNS Label"
  default     = "computesubnet"
}

variable "internet_gateway_name" {
  description = "OCI Internet Gateway Name"
  default     = "IGW"
}

variable "compute_route_table_display_name" {
  description = "OCI Compute Route Table Name"
  default     = "ComputeRouteTable"
}

variable "security_policy_name" {
  description = "OCI Security Policy Name"
  default     = "AzureSecurityList"
}

variable "oci_compute_instance_name" {
  description = "OCI Compute VM Name"
  default     = "oci-compute"
}
