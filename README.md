# Azure IoT Edge on Kubernetes: High Availability on Edge Computing

Edge devices are often used as [gateways](https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-as-gateway) to serve as a point of aggregation and compute for other devices/sensors. Configuring and managing gateway devices is challenging in systems that require high availability due the fact they tend to be a single point of failure.

**Azure IoT Edge on Kubernetes** allows us to introduce some redundancy at the gateway layer so that workloads can be migrated over to another gateway device in the event of a complete device failure.

## Prerequisites

- Azure resources tools: [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) with [IoT extension](https://github.com/Azure/azure-iot-cli-extension) and [Terraform](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure?toc=%2Fen-us%2Fazure%2Fterraform%2Ftoc.json&bc=%2Fen-us%2Fazure%2Fbread%2Ftoc.json#install-terraform)
- Kubernetes tools: [Helm CLI](https://docs.helm.sh/using_helm/#install-helm)
- Linux or Windows 10 with [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about)

## Getting Started

This lab is divided in the following steps:

- [Step 1: Create Azure Resources](./docs/create-azure-resources.md)
- [Step 2: Register gateway devices on IoT Hub](./docs/register-gateway-devices.md) 
- [Step 3: Setup Kubernetes cluster](./docs/setup-aks-cluster)