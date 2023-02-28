locals {
  location = "West Europe"
}

resource "azurerm_resource_group" "rg" {
  name     = "hackaton-rg"
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "hackaton-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "hackaton-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_resource_group" "workstations" {
  location = local.location
  name     = "hackaton-workstations-rg"

}

################################## Windows Workstations ##################################
locals {
  windows_vm_type          = "user"
  windows_vm_resource_name = "hackaton-windows-workstation"
  windows_vm_computer_name = "Workstation"
  windows_admin_username   = "hackaton"
  windows_instances_count  = 1
}

module "windows_workstations" {
  source = "git::https://Storm-Squad@dev.azure.com/Storm-Squad/Terrastorm/_git/module-vm?ref=2.1.1"

  # Environment variables
  resource_group_name = azurerm_resource_group.workstations.name
  subnet_id           = azurerm_subnet.subnet.id
  location            = local.location

  # Admin user
  admin_username = local.windows_admin_username
  admin_password = var.windows_admin_password

  # VM properties
  type            = local.windows_vm_type
  name            = local.windows_vm_resource_name
  instances_count = local.windows_instances_count

  depends_on = [
    azurerm_resource_group.workstations,
    azurerm_subnet.subnet
  ]
}
