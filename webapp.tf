/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_service_plan - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan

2. azurerm_windows_web_app - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app

*/


resource "azurerm_service_plan" "companyplan" {
  name                = "companyplan"
  resource_group_name = local.resource_group_name
  location            = local.location
  os_type             = "Windows"
  sku_name            = "S1"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_windows_web_app" "companyapp2030" {
  name                = "companyapp2030"
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.companyplan.id

  site_config {
    application_stack {
      current_stack="dotnet"
      dotnet_version="v6.0"
    }
  }

  app_settings = {
      "APPINSIGHT_INSTRUMENTATIONKEY" =azurerm_application_insights.appinsights.instrumentation_key
      "APPLICATIONINSIGHTS_CONNECTION_STRING" =azurerm_application_insights.appinsights.connection_string
}

  depends_on = [
    azurerm_service_plan.companyplan
  ]
}
