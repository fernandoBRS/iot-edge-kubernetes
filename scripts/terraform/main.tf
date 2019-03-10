provider "azurerm" {
    version = "~>1.19"
}

# Resource Group
resource "azurerm_resource_group" "k8s" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

# Storage Account for ACR
resource "azurerm_storage_account" "acr_storage" {
    name                     = "${var.storage_account_name}"
    resource_group_name      = "${azurerm_resource_group.k8s.name}"
    location                 = "${azurerm_resource_group.k8s.location}"
    account_tier             = "${var.storage_account_tier}"
    account_replication_type = "${var.storage_account_replication_type}"
}

# ACR
resource "azurerm_container_registry" "acr" {
    name                = "${var.acr_name}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    location            = "${azurerm_resource_group.k8s.location}"
    admin_enabled       = "${var.acr_admin_enabled}"
    sku                 = "${var.acr_sku}"
    storage_account_id  = "${azurerm_storage_account.acr_storage.id}"
}

# Storage Account for IoT Hub
resource "azurerm_storage_account" "iothub_storage" {
    name                     = "${var.iothub_storage_account_name}"
    resource_group_name      = "${azurerm_resource_group.k8s.name}"
    location                 = "${azurerm_resource_group.k8s.location}"
    account_tier             = "${var.iothub_storage_account_tier}"
    account_replication_type = "${var.iothub_storage_account_replication_type}"
}

resource "azurerm_storage_container" "iothub_storage_container" {
    name                  = "${var.iothub_storage_container_name}"
    resource_group_name   = "${azurerm_resource_group.k8s.name}"
    storage_account_name  = "${azurerm_storage_account.iothub_storage.name}"
    container_access_type = "${var.iothub_storage_container_access_type}"
}

# IoT Hub
resource "azurerm_iothub" "test" {
    name                = "${var.iothub_name}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    location            = "${azurerm_resource_group.k8s.location}"

    sku {
        name     = "${var.iothub_sku_name}"
        tier     = "${var.iothub_sku_tier}"
        capacity = "${var.iothub_sku_capacity}"
    }

    endpoint {
        type                       = "AzureIotHub.StorageContainer"
        connection_string          = "${azurerm_storage_account.iothub_storage.primary_blob_connection_string}"
        name                       = "export"
        batch_frequency_in_seconds = 60
        max_chunk_size_in_bytes    = 10485760
        container_name             = "${var.iothub_storage_container_name}"
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
        Environment = "dev"
    }
}

# AKS
resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "${var.k8s_cluster_name}"
    location            = "${azurerm_resource_group.k8s.location}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    dns_prefix          = "${var.k8s_dns_prefix}"

    agent_pool_profile {
        name            = "default"
        count           = "${var.k8s_agent_count}"
        vm_size         = "${var.k8s_vm_size}"
        os_type         = "Linux"
        os_disk_size_gb = "${var.k8s_os_disk_size}"
    }

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = "${file("${var.k8s_ssh_public_key}")}"
        }
    }

    service_principal {
        client_id     = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }

    tags {
        Environment = "dev"
    }
}

# Storage Account (AKS)

resource "azurerm_storage_account" "storage" {
    name                     = "${var.k8s_storage_account_name}"
    resource_group_name      = "${azurerm_kubernetes_cluster.k8s.node_resource_group}"
    location                 = "${azurerm_resource_group.k8s.location}"
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags {
        Environment = "dev"
    }
}

# Key Vault
# resource "azurerm_key_vault" "key_vault" {
#     name                        = "${var.keyvault_name}"
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
#         Environment = "dev"
#     }
# }
