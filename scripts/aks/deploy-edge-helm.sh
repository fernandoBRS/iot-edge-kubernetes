# Variables
keyvault_name="your_keyvault_name"
device_prefix="gateway"

# Get the device connection string on Key Vault
device_connection_string=$(az keyvault secret show --vault-name $keyvault_name --name $device_prefix-001 --query value -o tsv)

# Deploy the Edge helm chart
helm install \
    --name edgy \
    --set "deviceConnectionString=$device_connection_string" \
    edgek8s/edge-kubernetes