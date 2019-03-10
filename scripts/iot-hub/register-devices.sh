# Variables
resource_group_name="your_resource_group_name"
keyvault_name="your_keyvault_name"
iothub_name="your_iothub_name"
device_name="edge-gateway"

# Create two gateway devices
az iot hub device-identity create \
    --device-id $device_name \
    --hub-name $iothub_name \
    --edge-enabled

# Register the Key Vault provider
az provider register -n Microsoft.KeyVault

# Create a Key Vault
az keyvault create --name $keyvault_name --resource-group $resource_group_name

# Store the edge device connection string in Key Vault
az keyvault secret set \
    --vault-name $keyvault_name \
    --name $device_prefix-001 \
    --value $(az iot hub device-identity show-connection-string \
        --device-id $device_name \
        --hub-name $iothub_name \
        --query cs -o tsv)
