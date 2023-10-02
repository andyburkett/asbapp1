# refer to a resource group
data "azurerm_resource_group" "sonatabank" {
  name = "sonatabank"
}

#refer to a subnet
data "azurerm_subnet" "sonatabank" {
  name                 = "inf-subnet"
  virtual_network_name = "sonatabank-vn1"
  resource_group_name  = "sonatabank"
}

# Create public IPs
#resource "azurerm_public_ip" "sonatabank" {
#    name                         = "publicIP-inf-test1"
#    location                     = "${data.azurerm_resource_group.sonatabank.location}"
#    resource_group_name          = "${data.azurerm_resource_group.sonatabank.name}"
#    allocation_method            = "Dynamic"
#}

# create a network interface
resource "azurerm_network_interface" "sonatabank" {
  name                = "asbapp1-nic1"
  location            = "${data.azurerm_resource_group.sonatabank.location}"
  resource_group_name = "${data.azurerm_resource_group.sonatabank.name}"

  ip_configuration {
    name                          = "asbapp1-ip1"
    subnet_id                     = "${data.azurerm_subnet.sonatabank.id}"
#   private_ip_address_allocation = "Dynamic"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.250.100.20"
#    public_ip_address_id          = "${azurerm_public_ip.sonatabank.id}"
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "sonatabank" {
    name                  = "asbapp1"
    location              = "${azurerm_network_interface.sonatabank.location}"
    resource_group_name   = "${data.azurerm_resource_group.sonatabank.name}"
    network_interface_ids = ["${azurerm_network_interface.sonatabank.id}"]
    vm_size               = "Standard_D2s_v3"

# Uncomment this line to delete the OS disk automatically when deleting the VM
delete_os_disk_on_termination = true

# Uncomment this line to delete the data disks automatically when deleting the VM
delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

   storage_os_disk {
    name              = "asbapp1-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
   os_profile {
    computer_name  = "asbapp1"
    admin_username = "sbadministrator"
    admin_password = "]xCfz1+Y$La2lMmYNO8("
  }
   os_profile_windows_config {
  }

}