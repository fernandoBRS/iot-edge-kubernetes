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