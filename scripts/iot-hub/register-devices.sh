# Variables
resource_group_name="rg-contoso-dev"
keyvault_name="contosokvaultdev"
iothub_name="contosohubdev"
device_prefix="gateway"

# Create two gateway devices
az iot hub device-identity create \
    --device-id $device_prefix-001 \
    --hub-name $iothub_name \
    --edge-enabled

az iot hub device-identity create \
    --device-id $device_prefix-002 \
    --hub-name $iothub_name \
    --edge-enabled

# Register the Key Vault provider
az provider register -n Microsoft.KeyVault

# Create a Key Vault
az keyvault create --name $keyvault_name --resource-group $resource_group_name

# Store connection strings from edge devices in Key Vault
az keyvault secret set \
    --vault-name $keyvault_name \
    --name $device_prefix-001 \
    --value $(az iot hub device-identity show-connection-string \
        --device-id $device_prefix-001 \
        --hub-name $iothub_name \
        --query cs -o tsv)

az keyvault secret set \
    --vault-name $keyvault_name \
    --name $device_prefix-002 \
    --value $(az iot hub device-identity show-connection-string \
        --device-id $device_prefix-002 \
        --hub-name $iothub_name \
        --query cs -o tsv)