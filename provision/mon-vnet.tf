
 # vnet for network services
resource "azurerm_virtual_network" "jmontest-network" {
  name                = "jmontest-network"
  address_space       = ["11.1.0.0/29"]
  location            = var.a00_location
  resource_group_name = azurerm_resource_group.corda-jmontest.name

  tags = {
    Environment = var.envname
   }
}
 
resource "azurerm_subnet" "jmontest-public" {
  name                 = "jmontest-public"
  resource_group_name  = azurerm_resource_group.corda-jmontest.name
  virtual_network_name = azurerm_virtual_network.jmontest-network.name
  address_prefix       = "11.1.0.0/29"
}

