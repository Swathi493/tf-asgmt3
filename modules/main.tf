
data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
  include_preview = false
}
resource "azurerm_log_analytics_workspace" "insights" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  retention_in_days   = 30
  sku                 = "PerGB2018"
}
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  

  default_node_pool {
    name                 = var.node_pool_name
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    
    enable_auto_scaling  = true
    node_count           = 2
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = var.environment
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
    } 
   tags = {
      "nodepool-type"    = "system"
      "environment"      = var.environment
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
   } 
  }

   

  identity {
    type = "SystemAssigned"
  }

  #azure_active_directory_role_based_access_control{
      #managed = true
      #admin_group_object_ids = [azuread_group.aks_administrators.id]
    #}
  
    azure_policy_enabled = true
    oms_agent {
      
      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
    }
    linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }
  

  




  


  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }

  tags =var.tags
}

