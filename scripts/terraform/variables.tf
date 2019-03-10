# Service Principal
variable "sp_name" {
    description = "Service Principal name"
    default = "contoso-sp-aks-dev"
}

variable "sp_least_privilege" {
    default = false
}

# Resource Group
variable resource_group_name {
    description = "Resource group name"
    default = "rg-contoso-dev"
}

variable location {
    default = "East US"
}

# Storage Account (ACR)
variable "storage_account_name" {
    description = "Storage account name"
    default = "contosostgacctdev"
}

variable "storage_account_tier" {
    description = "Storage account tier"
    default = "Standard"
}

variable "storage_account_replication_type" {
    description = "Storage account replication type"
    default = "GRS"
}

# Container Registry

variable "acr_name" {
    description = "ACR name"
    default = "contosoregistrydev"
}

variable "acr_admin_enabled" {
    description = "ACR admin enabling flag"
    default = true
}

variable "acr_sku" {
    description = "ACR SKU type"
    default = "Classic"
}

# Storage Account (IoT Hub)
variable "iothub_storage_account_name" {
    description = "Storage account name for IoT Hub"
    default = "contosostgacctdev"
}

variable "iothub_storage_account_tier" {
    description = "Storage account tier"
    default = "Standard"
}

variable "iothub_storage_account_replication_type" {
    description = "Storage account replication type"
    default = "LRS"
}

# Storage container (IoT Hub)
variable "iothub_storage_container_name" {
    description = "Storage container name for the IoT Hub"
    default = "defaultdev"
}

variable "iothub_storage_container_access_type" {
    description = "Storage container access type"
    default = "private"
}

# IoT Hub
variable "iothub_name" {
    description = "IoT Hub name"
    default = "contosohubdev"
}

variable "iothub_sku_name" {
    description = "IoT Hub SKU name"
    default = "S1"
}

variable "iothub_sku_tier" {
    description = "IoT Hub SKU tier"
    default = "Standard"
}

variable "iothub_sku_capacity" {
    description = "IoT Hub SKU capacity"
    default = "1"
}

# Key Vault
# variable "keyvault_name" {
#     description = "Key Vault name"
#     type = "map"
#     default = {
#         dev     = "contosokvaultdev"
#         prod    = "contosokvault"
#     }
# }

# variable "tenant_id" {
#     description = "Tenant ID for Key Vault"
#     default     = "your_tenant_id"
# }

# AKS
variable k8s_cluster_name {
    description = "Kubernetes cluster name"
    default = "contosoclusterdev"
}

variable "k8s_dns_prefix" {
    description = "Kubernetes DNS name prefix"
    default = "contosoclusterdev"
}

variable "k8s_agent_count" {
    description = "Number of Kubernetes nodes"
    default = 1
}

variable "k8s_vm_size" {
    description = "Kubernetes VM size"
    default = "Standard_B2s"
}

variable "k8s_os_disk_size" {
    description = "Kubernetes OS disk size"
    default = 30
}

variable "k8s_ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

# Service Principal
variable "client_id" {
    description = "Service Principal client ID"
}

variable "client_secret" {
    description = "Service Principal secret"
}

# Storage Account
variable "k8s_storage_account_name" {
    description = "Storage account name used for Kubernetes persistent storage"
    default = "contosostgaccntdev"
}
