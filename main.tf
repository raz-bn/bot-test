locals {
  location = "West Europe"
}

resource "azurerm_resource_group" "rg" {
  name     = "zurimoni-rg"
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
