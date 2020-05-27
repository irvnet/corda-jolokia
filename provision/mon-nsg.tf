resource "azurerm_network_security_group" "montest-nsg" {
  name                = "open-montest-nsg"
  location            = var.a00_location
  resource_group_name = azurerm_resource_group.corda-montest.name

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




   tags = {
    Customer    = var.customer
    Purpose     = var.purpose
    Environment = var.envname
    Builder     = var.builder
   }
   
}
