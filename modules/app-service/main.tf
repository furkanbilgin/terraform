resource "azurerm_service_plan" "service-plan-api" {
  name                = var.serviceplan_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Windows"
  sku_name            = "P3v3"
  worker_count        = 1
  tags = var.default_tags

}

resource "azurerm_windows_web_app" "app_service_api" {
  name                = var.appservice_name
  public_network_access_enabled = true
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.service-plan-api.id
  tags                = var.default_tags
  
  virtual_network_subnet_id         = ""
  #vnet integration için kullanılacak subnet
  
  https_only              = false
  client_affinity_enabled = true

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true

    application_logs {
      file_system_level = "Verbose"

      azure_blob_storage {
        level             = "Verbose"
        retention_in_days = 1441
        sas_url           = ""
      }
    }

    http_logs {
      file_system {
        retention_in_days = 1441
        retention_in_mb   = 35
      }
    }
  }

  site_config {
    minimum_tls_version       = "1.2"
    use_32_bit_worker         = false
    managed_pipeline_mode     = "Integrated"
    ftps_state                = "FtpsOnly"
    http2_enabled             = true
    websockets_enabled        = false     
    always_on                 = true
    remote_debugging_enabled  = false
    vnet_route_all_enabled = true

    application_stack{
    current_stack =  "dotnet"
    dotnet_version= "v4.0"
    } 

     

     ip_restriction{ 
    action     = "Allow"
    ip_address = "212.252.204.0/22"
    name       = "polat_subnet"
    priority   = 100
    }  

    ip_restriction{
    #virtual_network_subnet_id = var.vnet_subnet_id
    action     = "Allow"
    ip_address = "10.102.30.0/23"
    name       = "snet-Test-Service-00TR_subnet_id"
    priority   = 101
    }   
  }

  app_settings = {
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.azapp_api_application_insights.connection_string
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.azapp_api_application_insights.instrumentation_key
    "WEBSITE_TIME_ZONE"        = "Turkey Standard Time"
    
  } 
}

resource "azurerm_application_insights" "azapp_api_application_insights" {
  name                = var.azurerm_application_insight_name 
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = "web"
  tags = var.default_tags
}

output "instrumentation_key" {
  value = azurerm_application_insights.azapp_api_application_insights.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.azapp_api_application_insights.app_id
}

# önce azure panelden verification id alınıp dns kaydı eklenmeli
# veya terraform apply yaptığımızda çıkacak uyarılarda bulunan dns kayıt bilgileri alınıp dns servera eklenmelidir.

resource "azurerm_app_service_custom_hostname_binding" "api_test_custom_hostname" {
  hostname            = "api.furkanbilgin.com"
  app_service_name    = var.appservice_name
  resource_group_name = var.rg_name
}

resource "azurerm_private_endpoint" "test_api_private_endpoint" {
  name                = "azapp-api-test-001"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = ""
  #private endpointin bulunacağı subnet ID

  private_service_connection {
    name                           = "prv-srv-con-azapp-api-test-001"
    private_connection_resource_id = azurerm_windows_web_app.app_service_api.id
    subresource_names             = [  "sites" ] 
    is_manual_connection           = false
  }

  ip_configuration {
    name               = "azapp-api-test-001"
    subresource_name   = "sites"
    private_ip_address = var.azapp_api_test_001_pe_ip_addresses
  }

}
