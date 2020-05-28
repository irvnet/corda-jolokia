resource "azurerm_network_security_group" "jmontest-nsg" {
  name                = "jmontest-nsg"
  location            = var.a00_location
  resource_group_name = azurerm_resource_group.corda-jmontest.name

  security_rule {
    name = "SSH_inbound"
    priority = 200
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "hawtio_inbound"
    priority = 210
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "8080"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }


   tags = {
    Environment = var.envname
   }
   
}
