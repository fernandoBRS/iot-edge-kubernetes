# Create Azure Resources

These are the Azure resources we are going to use:

| Resource | Description |
| -------------- | -------------- |
| [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes) | Kubernetes cluster for IoT Edge deployments |
| [Azure IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/about-iot-hub) | Service for managing edge applications and devices |
| [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro) | Repository for Docker images |
| [Azure Storage Account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview) | Service used for Kubernetes persistent storage |

If you already have these services in your environment, feel free to reuse it. Otherwise, we are going to use [Terraform](https://www.terraform.io/) for building, changing, and versioning our infrastructure. 

## Create Service Principal

The AKS cluster requires a Service Principal. Run the following script to create a new one:

    az ad sp create-for-rbac --name YourServicePrincipalName 

Copy the `appId` and `password` generated and export them as Terraform variables:

```sh
export TF_VAR_client_id=<your-client-id>
export TF_VAR_client_secret=<your-client-secret>
```

## Terraform setup

Terraform workspaces allows you to manage multiple distinct sets of infrastructure resources/environments. In the `scripts/terraform` folder, open the `variables.tf` file and edit all variable values you want in your environment.

Initialize Terraform and install the Azure provider:

```sh
terraform init
```

Then start the execution plan and wait for all resources to be created:

```sh
terraform apply
```

## Next Step

- [Register gateway devices on IoT Hub](./register-gateway-devices.md)
