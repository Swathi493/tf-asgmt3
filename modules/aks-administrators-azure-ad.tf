#data "azuread_client_config" "current" {}

#resource "azuread_group" "aks_administrators" {
 #display_name     = "example"
 #owners           = [data.azuread_client_config.current.object_id]
  #security_enabled = true
#}