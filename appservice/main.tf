###backend configuration###
terraform {
  backend "azurerm" {
    resource_group_name  = "****"
    storage_account_name = "****"
    container_name       = "****"
    key                  = "****"
  }
}
###backend configuration###

###provider###
provider "azurerm" {
  features {}
}
###provider###

module "app-service" {  
  source     = "./modules/app-service"
  location   = var.location
  rg_name    = var.rg_name
  default_tags = var.default_tags
}

module "frontdoor" {  
  source     = "./modules/frontdoor"
  location   = var.location
  rg_name    = var.rg_name
  default_tags = var.default_tags
}