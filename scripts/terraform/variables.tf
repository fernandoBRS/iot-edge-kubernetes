variable "workspace_to_environment_map" {
    description = "A set of known environments (workspaces)"
    type = "map"
    default = {
        dev     = "dev"
        prod    = "prod"
    }
}

# Resource Group
variable resource_group_name {
    description = "Resource group name"
    type = "map"
    default = {
        dev     = "rg-contoso-dev"
        prod    = "rg-contoso"
    }
}

variable location {
    default = "East US"
}

# Container Registry
variable "storage_account_name" {
    description = "Storage account name that will be used for Container Registry"
    type = "map"
    default = {
        dev     = "contosostgacctdev"
        prod    = "contosostgacct"
    }
}
variable "container_registry_name" {
    description = "Container Registry name"
    type = "map"
    default = {
        dev     = "contosoregistrydev"
        prod    = "contosoregistry"
    }
}

# IoT Hub
variable "iothub_storage_account_name" {
    description = "Storage account name for IoT Hub"
    type = "map"
    default = {
        dev     = "contosostgacctdev"
        prod    = "contosostgacct"
    }
}

variable "iothub_storage_container_name" {
    description = "Storage container name for the IoT Hub"
    type = "map"
    default = {
        dev     = "defaultdev"
        prod    = "default"
    }
}

variable "iothub_name" {
    description = "IoT Hub name"
    type = "map"
    default = {
        dev     = "contosohubdev"
        prod    = "contosohub"
    }
}

variable "iothub_sku_name" {
    description = "IoT Hub SKU name"
    type = "map"
    default = {
        dev     = "S1"
        prod    = "S1"
    }
}

variable "iothub_sku_tier" {
    description = "IoT Hub SKU tier"
    type = "map"
    default = {
        dev     = "Standard"
        prod    = "Standard"
    }
}

variable "iothub_sku_capacity" {
    description = "IoT Hub SKU capacity"
    type = "map"
    default = {
        dev     = "1"
        prod    = "4"
    }
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
    type = "map"
    default = {
        dev     = "contosoclusterdev"
        prod    = "contosocluster"
    }
}

variable "k8s_dns_prefix" {
    description = "Kubernetes DNS name prefix"
    type = "map"
    default = {
        dev     = "contosoclusterdev"
        prod    = "contosocluster"
    }
}

variable "k8s_agent_count" {
    description = "Number of Kubernetes nodes"
    type = "map"
    default = {
        dev     = 1
        prod    = 3
    }
}

variable "k8s_vm_size" {
    description = "Kubernetes VM size"
    type = "map"
    default = {
        dev     = "Standard_B2s"
        prod    = "Standard_DS2_v2"
    }
}

variable "k8s_os_disk_size" {
    description = "Kubernetes OS disk size"
    type = "map"
    default = {
        dev     = 30
        prod    = 30
    }
}

variable "k8s_linux_profile_username" {
    description = "Username for authentication to the AKS linux agent VMs in the cluster"
    type = "map"
    default = {
        dev     = "contosoadmindev"
        prod    = "contosoadmin"
    }
}

variable "k8s_ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "sp_name" {
    description = "Service Principal name"
    type = "map"
    default = {
        dev     = "contoso-sp-aks-dev"
        prod    = "contoso-sp-aks"
    }
}

variable "sp_least_privilege" {
    default = false
}

# Storage Account
variable "k8s_storage_account_name" {
    description = "Storage account name used for Kubernetes persistent storage"
    type = "map"
    default = {
        dev     = "contosostgaccntdev"
        prod    = "contosostgaccnt"
    }
}