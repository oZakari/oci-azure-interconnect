# ------ Create Azure Resource Group
resource "azurerm_resource_group" "resource_group" {
  provider = azurerm.azure
  name     = lower(join("-", ["interconnect", var.peering_location, "rg"]))
  location = var.azure_region
}
