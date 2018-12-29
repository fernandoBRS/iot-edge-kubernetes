# Step 1: Create Azure Resources

These are the Azure resources we need:

| Resource | Description |
| -------------- | -------------- |
| [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes) | Kubernetes cluster for IoT Edge deployments |
| [Azure IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/about-iot-hub) | Service for managing edge applications and devices |
| [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro) | Repository for Docker images |
| [Azure Storage Account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview) | Service used for Kubernetes persistent storage |

If you already have these services in your environment, feel free to reuse it. Otherwise, we are going to use [Terraform](https://www.terraform.io/) for building, changing, and versioning our infrastructure. 

## Terraform setup

Terraform workspaces allows you to manage multiple distinct sets of infrastructure resources/environments. In the `scripts/terraform` folder, open the `variables.tf` file and edit all variable values you want in your environment.

Run the script to create `dev` and `prod` workspaces:

```sh
./create-workspaces.sh 
```

Select the development workspace:

```sh
terraform workspace select dev
```

Initialize Terraform and install the Azure provider:

```sh
terraform init
```

Then start the execution plan and wait for all resources to be created:

```sh
terraform apply
```

## Next Steps

At this point you have provisioned all Azure resources we need. In the next step, we are going to register a gateway device on IoT Hub by following the tutorial described [here](./register-gateway-devices.md).