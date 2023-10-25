resource "azurerm_log_analytics_workspace" "appworkspace" {
  name                = "appworkspace1234567"
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appinsights" {
  name                = "appinsights1234567"
  location            = local.location
  resource_group_name = local.resource_group_name
  application_type    = "web"
  workspace_id = azurerm_log_analytics_workspace.appworkspace.id
  depends_on = [
    azurerm_log_analytics_workspace.appworkspace
  ]
}