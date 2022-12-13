

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "devops-rg"
}

variable "location" {
  type        = string
  description = "Location for deploying resources"
  default     = "eastus"
}

variable "cluster_name" {
  type        = string
  description = "name of the kubernetes cluster"
  default     = "swathi1179"
}
variable "node_pool_name" {
  type        = string
  description = "name of the nodepool"
  default     = "systempool"
}
variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of log_analytics_workspace"
  default     = "log-swathi1179"
}
variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  default = "dev"
}
variable "ssh_public_key" {
  default =  "sshkey.pub"
  
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

variable "tags" {
  type = object({
    created_by       = string
    created_for      = string
    
  })
}





