provider "azurerm" {
    version = "~>1.19"
}

locals {
    # If the Terraform workspace name does not exist in the map, it will default to dev
    environment = "${lookup(var.workspace_to_environment_map, terraform.workspace, "dev")}"
}

# Create a service principal for use in the AKS cluster
module "service_principal" {
  source = "service_principal"

  sp_least_privilege = "${var.sp_least_privilege}"
  sp_name             = "${var.sp_name[local.environment]}"
}

# Resource Group
resource "azurerm_resource_group" "k8s" {
    name     = "${var.resource_group_name[local.environment]}"
    location = "${var.location}"
}

# Container Registry
resource "azurerm_storage_account" "acr_storage" {
    name                     = "${var.storage_account_name[local.environment]}"
    resource_group_name      = "${azurerm_resource_group.k8s.name}"
    location                 = "${azurerm_resource_group.k8s.location}"
    account_tier             = "Standard"
    account_replication_type = "GRS"
}

resource "azurerm_container_registry" "acr" {
    name                = "${var.container_registry_name[local.environment]}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    location            = "${azurerm_resource_group.k8s.location}"
    admin_enabled       = true
    sku                 = "Classic"
    storage_account_id  = "${azurerm_storage_account.acr_storage.id}"
}

# AKS
resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "${var.k8s_cluster_name[local.environment]}"
    location            = "${azurerm_resource_group.k8s.location}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    dns_prefix          = "${var.k8s_dns_prefix[local.environment]}"

    agent_pool_profile {
        name            = "default"
        count           = "${var.k8s_agent_count[local.environment]}"
        vm_size         = "${var.k8s_vm_size[local.environment]}"
        os_type         = "Linux"
        os_disk_size_gb = "${var.k8s_os_disk_size[local.environment]}"
    }

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = "${file("${var.k8s_ssh_public_key}")}"
        }
    }

    service_principal {
        client_id     = "${module.service_principal.client_id}"
        client_secret = "${module.service_principal.client_secret}"
    }

    tags {
        Environment = "${local.environment}"
    }
}