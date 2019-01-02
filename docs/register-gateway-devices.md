# Register gateway devices on IoT Hub

Before using your edge devices with IoT Edge, you need to register them on IoT Hub. Open the `register-devices.sh` script located in `scripts/iot-hub` in a text editor and update the following variables:

```sh
resource_group_name="your_resource_group_name"
keyvault_name="your_keyvault_name"
iothub_name="your_iothub_name"
device_prefix="gateway"
```

*Note: The script assumes you're going to use the same Resource Group and IoT Hub created on the previous step. The Key Vault is a new resource, so you can add the name you want.*

Then run the script:

```sh
./register-devices.sh
```

The script will create an edge device called `gateway-001` and will store the device connection strings as a secret in a new [Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/key-vault-overview). We are going to use key vault to protect the device connection string and to avoid hardcode it in a script.

## Next Steps

The next step is setting up your Kubernetes cluster to install IoT Edge dependencies based on both edge devices we created: [Setup the Kubernetes cluster](./setup-aks-cluster.md).

