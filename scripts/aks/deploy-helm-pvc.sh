# Variables
keyvault_name="your_keyvault_name"
device_prefix="gateway"
storage_class_name="azurefile"
pvc_name="iotedged-pvc"

# Get the device connection string on Key Vault
device_connection_string=$(az keyvault secret show --vault-name $keyvault_name --name $device_prefix-001 --query value -o tsv)

# Deploy the Edge helm chart with persistent volume
helm install \
    --name edgy \
    --set "deviceConnectionString=$device_connection_string" \
    --set "iotedged.data.persistentVolumeClaim.name=$pvc_name" \
    --set "iotedged.data.persistentVolumeClaim.storageClassName=$storage_class_name" \
    edgek8s/edge-kubernetes