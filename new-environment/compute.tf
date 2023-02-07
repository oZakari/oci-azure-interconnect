# ------ Create Compute VM Network Interface Card
resource "azurerm_network_interface" "compute_vm_vnic" {
  provider            = azurerm.azure
  for_each            = toset(local.region_availability_zones[var.azure_region])
  name                = join("-", [var.azure_compute_vnic_name, "zone", each.value])
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.compute_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# ------ Create Compute VM on Azure
resource "azurerm_linux_virtual_machine" "azure_compute_vm" {
  provider                        = azurerm.azure
  for_each                        = toset(local.region_availability_zones[var.azure_region])
  name                            = join("-", [var.azure_compute_machine_name, "zone", each.value])
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = azurerm_resource_group.resource_group.location
  zone                            = each.value
  size                            = "Standard_D2as_v4"
  disable_password_authentication = "false"
  admin_username                  = "adminuser"
  admin_password                  = var.vm_pw
  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.ssh_public_key_path)
  }
  network_interface_ids = [
    azurerm_network_interface.compute_vm_vnic[each.value].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Oracle"
    offer     = "Oracle-Linux"
    sku       = "ol9-lvm"
    version   = "latest"
  }
}

# ------ Create Compute VM on OCI
resource "oci_core_instance" "oci_compute_instance" {
  provider            = oci.oci
  count               = length(data.oci_identity_availability_domains.ads.availability_domains)
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[count.index], "name")
  compartment_id      = oci_identity_compartment.compartment.id
  display_name        = join("-", [var.oci_compute_instance_name, "domain", count.index + 1])
  shape               = var.instance_shape

  shape_config {
    baseline_ocpu_utilization = "BASELINE_1_1"
    memory_in_gbs             = "8"
    ocpus                     = "4"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.compute_subnet[count.index].id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.instance_image_ocid.images[0].id
  }

  timeouts {
    create = "10m"
  }
}
