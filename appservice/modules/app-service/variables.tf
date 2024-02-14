variable "serviceplan_name" {
    default = "asp-test-api"
}

variable "appservice_name" {
    default = "azapp-api-test-001"
}

variable "azurerm_application_insight_name" {
    default = "test-api-test-application-insights"
}

variable "vnet_subnet_id" {
    default = ""
    # kullanılacak subnet id
}

variable "private_endpoint_name" {
    default = "pe-api-test"
}

variable "azapp_api_test_001_pe_ip_addresses" {
    default = "**.**.**.**"
    # private endpointe ait static ip adresi
}



variable "rg_name" {}
variable "location" {}
variable "default_tags" {}
 