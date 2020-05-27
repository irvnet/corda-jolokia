
resource "azurerm_resource_group" "corda-jmontest" {
  name = "corda-jmontest"
  location = var.a00_location

  tags = {
    Environment = var.envname
   }
}
