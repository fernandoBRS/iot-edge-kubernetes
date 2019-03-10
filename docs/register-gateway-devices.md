# Register gateway devices on IoT Hub

In this step we're going to register a new gateway device on IoT Hub and use Key Vault to store the device connection string to avoid hardcode it our scripts. 

Open the `register-devices.sh` script located in `scripts/iot-hub` in a text editor and update the following variables:

```sh
resource_group_name="your_resource_group_name"
keyvault_name="your_keyvault_name"
iothub_name="your_iothub_name"
device_name="edge-gateway"
```

*Note: The script assumes you're going to use the same Resource Group and IoT Hub created on the previous step. The Key Vault is a new resource, so you can add the name you want.*

Then run the script:

```sh
./register-devices.sh
```

## Next Steps

The next step is setting up your Kubernetes cluster to install IoT Edge dependencies based on both edge devices we created: [Setup the Kubernetes cluster](./setup-aks-cluster.md).

