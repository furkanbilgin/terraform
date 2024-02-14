resource "azurerm_cdn_frontdoor_profile" "my_front_door_profile" {
  name                = "azapp-api-test-frontdoor"
  resource_group_name = var.rg_name
  sku_name            = "Premium_AzureFrontDoor"
    tags                = var.default_tags
}

resource "azurerm_cdn_frontdoor_origin_group" "my_origin_group" {
  name                     = "azapp-api-test-frontdoor-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.my_front_door_profile.id
  session_affinity_enabled = false

  load_balancing {
  }

  health_probe {
    interval_in_seconds = 100
    path                = "/health-check.html"
    protocol            = "Http"
    request_type        = "GET"
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "api_test_Fd_EndPoint" {
  name                     = "azapp-api-test-fd-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.my_front_door_profile.id
    tags                = var.default_tags
}

resource "azurerm_cdn_frontdoor_origin" "api_test_Fd_Origin" {
  name = "azapp-api-test-origin"

  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.my_origin_group.id
  enabled                        = true
  certificate_name_check_enabled = true

  host_name          = "azapp-api-test.azurewebsites.net"
  http_port          = 80
  https_port         = 443
  origin_host_header = "azapp-api-test.azurewebsites.net"
  priority           = 1
  weight             = 1000

  private_link {
    location               = "westeurope"
    private_link_target_id = "APP SERVİCE ID"
    request_message        = "azapp-api-test Front Door Connection Request"
    target_type            = "sites"
  }
}

resource "azurerm_cdn_frontdoor_rule_set" "api_test_Rule_Set" {
  name                     = "azapp-api-testFdRuleSet"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.my_front_door_profile.id
}

resource "azurerm_cdn_frontdoor_route" "api_test_Fd_Route" {
  name                          = "default-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.api_test_Fd_EndPoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.my_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.api_test_Fd_Origin.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.api_test_Rule_Set.id]
  enabled                       = true

  forwarding_protocol    = "MatchRequest"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.oim_custom_domain.id]

  cache {
    compression_enabled = true
    content_types_to_compress = [
      "application/eot",
      "application/font",
      "application/font-sfnt",
      "application/javascript",
      "application/json",
      "application/opentype",
      "application/otf",
      "application/pkcs7-mime",
      "application/truetype",
      "application/ttf",
      "application/vnd.ms-fontobject",
      "application/xhtml+xml",
      "application/xml",
      "application/xml+rss",
      "application/x-font-opentype",
      "application/x-font-truetype",
      "application/x-font-ttf",
      "application/x-httpd-cgi",
      "application/x-javascript",
      "application/x-mpegurl",
      "application/x-opentype",
      "application/x-otf",
      "application/x-perl",
      "application/x-ttf",
      "font/eot",
      "font/ttf",
      "font/otf",
      "font/opentype",
      "image/svg+xml",
      "text/css",
      "text/csv",
      "text/html",
      "text/javascript",
      "text/js",
      "text/plain",
      "text/richtext",
      "text/tab-separated-values",
      "text/xml",
      "text/x-script",
      "text/x-component",
      "text/x-java-source",
    ]
    query_string_caching_behavior = "IgnoreQueryString"
    query_strings                 = []
  }

  link_to_default_domain = false

}

resource "azurerm_cdn_frontdoor_custom_domain" "oim_custom_domain" {
  name                     = "appservicetestdomain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.my_front_door_profile.id
  host_name                = "api.furkanbilgin.com"

  tls {
    //certificate_type    = "CustomerCertificate"
    certificate_type = "CustomerCertificate"
    minimum_tls_version = "TLS12"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "domain_association" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.oim_custom_domain.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.api_test_Fd_Route.id]
}
