# ------ Initialize Azure Terraform provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.32.0"
    }
    oci = {
      source = "oracle/oci"
    }
  }
}
provider "azurerm" {
  alias   = "azure"
  features {}
}

# ------ Initialize Oracle Terraform provider
provider "oci" {
  alias            = "oci"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

