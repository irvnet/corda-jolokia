

resource "azurerm_public_ip" "jmontest-publicip" {
  name                         = "jmontest-publicip"
  resource_group_name          = azurerm_resource_group.corda-jmontest.name
  location                     = var.a00_location
  domain_name_label            = "jmontest"
  allocation_method            = "Static"

}

resource "azurerm_network_interface" "jmontest-nic" {
  name                       = "jmontest-nic"
  location                   = var.a00_location
  resource_group_name        = azurerm_resource_group.corda-jmontest.name
  network_security_group_id  = azurerm_network_security_group.jmontest-nsg.id

    ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.jmontest-public.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.jmontest-publicip.id
  }
}

resource "azurerm_virtual_machine" "jmontest" {
  name                  = "jmontest-env"
  location              = var.a00_location
  resource_group_name   = azurerm_resource_group.corda-jmontest.name
  network_interface_ids = [azurerm_network_interface.jmontest-nic.id]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "jmontestosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "jmontest-env"
    admin_username = "ubuntu"
    admin_password = "password"
  }

  # TODO: UPDATE KEY_DATA WITH YOUR PUBLIC KEY
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
       path     = "/home/ubuntu/.ssh/authorized_keys"
       key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5/kobhdFXNNrQlvGXQ4M7YKN9le79KtJw+4vCmGKThjBZPHKh7fm2l2jmnhRT21ifzMo879gxPbx6DR2NlkEKw4bIu9qCMBXp+hCvcYz4VteWkT1Vx0oWznBAfENUScfo4Rrs11cJ1Nh8qOlrR/25r4oWMTM+OOQmQPlpSEOK0bSnrn/RhVT4IOUiU70kHOXbPjSZf9p5yzfx6HO5a2gEqPvXmVCl4w0B4y8Aibfo7GQrtL7BAhKZLDhPzsaMH7qrs/PjvDW8PNfVmjlX7z3ORYYCglgWzQAhqi4W0r8nVggpEmFeOtAKosejQIiY+lofCDHObQiBet8nRblcMZPP richardirving@MacBook-Dev-04"
    }
  }


  # TODO: UPDATE TO REFENRECE YOUR PRIVATE KEY FILE ON THE CONTROL MACHINE
 provisioner "file" {
    source      = "./scripts/prep.sh"
    destination = "$HOME/prep.sh"

    connection {
      type     = "ssh"
      host     = azurerm_public_ip.jmontest-publicip.fqdn
      port     = "22"
      timeout  = "120s"
      user     = "ubuntu"
      private_key = file("../keys/mon_rsa")
    } 
  }

provisioner "remote-exec" {
  inline = [
    "chmod +x $HOME/prep.sh",
    "sudo $HOME/prep.sh",
    "rm $HOME/prep.sh",
  ]


  # TODO: UPDATE TO REFENRECE YOUR PRIVATE KEY FILE ON THE CONTROL MACHINE
  connection {
    type     = "ssh"
    host     = azurerm_public_ip.jmontest-publicip.fqdn
    port     = "22"
    timeout  = "120s"
    user     = "ubuntu"
    private_key = file("../keys/mon_rsa")
  } 
}


}
