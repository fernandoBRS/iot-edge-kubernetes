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

# IoT Hub
resource "azurerm_storage_account" "iothub_storage" {
    name                     = "${var.iothub_storage_account_name[local.environment]}"
    resource_group_name      = "${azurerm_resource_group.k8s.name}"
    location                 = "${azurerm_resource_group.k8s.location}"
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_storage_container" "iothub_storage_container" {
    name                  = "${var.iothub_storage_container_name[local.environment]}"
    resource_group_name   = "${azurerm_resource_group.k8s.name}"
    storage_account_name  = "${azurerm_storage_account.iothub_storage.name}"
    container_access_type = "private"
}

resource "azurerm_iothub" "test" {
    name                = "${var.iothub_name[local.environment]}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    location            = "${azurerm_resource_group.k8s.location}"

    sku {
        name     = "${var.iothub_sku_name[local.environment]}"
        tier     = "${var.iothub_sku_tier[local.environment]}"
        capacity = "${var.iothub_sku_capacity[local.environment]}"
    }

    endpoint {
        type                       = "AzureIotHub.StorageContainer"
        connection_string          = "${azurerm_storage_account.iothub_storage.primary_blob_connection_string}"
        name                       = "export"
        batch_frequency_in_seconds = 60
        max_chunk_size_in_bytes    = 10485760
        container_name             = "${var.iothub_storage_container_name[local.environment]}"
        encoding                   = "Avro"
        file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
    }

    route {
        name           = "export"
        source         = "DeviceMessages"
        condition      = "true"
        endpoint_names = ["export"]
        enabled        = true
    }

    tags {
        Environment = "${local.environment}"
    }
}

# Key Vault
# resource "azurerm_key_vault" "key_vault" {
#     name                        = "${var.keyvault_name[local.environment]}"
#     location                    = "${azurerm_resource_group.k8s.location}"
#     resource_group_name         = "${azurerm_resource_group.k8s.name}"
#     enabled_for_disk_encryption = true
#     tenant_id                   = "${var.tenant_id}"

#     sku {
#         name = "standard"
#     }

#     access_policy {
#         tenant_id = "${var.tenant_id}"
#         object_id = "${module.service_principal.sp_id}"

#         key_permissions = [
#             "get",
#         ]

#         secret_permissions = [
#             "get", "set"
#         ]
#     }

#     # network_acls {
#     #     default_action = "Deny"
#     #     bypass         = "AzureServices"
#     # }

#     tags {
#         Environment = "${local.environment}"
#     }
# }

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