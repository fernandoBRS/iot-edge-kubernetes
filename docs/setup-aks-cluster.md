# Setup the Kubernetes cluster

## Connect with the cluster

Follow the tutorial described [here](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster) to connect to your Kubernetes cluster locally. If you want to open the dashboard, run the following command:

```bash
az aks browse --resource-group resourceGroupName --name clusterName
```

## Grant Kubernetes access to Azure Container Registry

Before building and deploying the solution make sure your Kubernetes cluster has granted access to your Container Registry by following the tutorial described [here](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-aks).

## Install Tiller

Create a service account on AKS to enable tye use of Tiller by running the following script in the `scripts/aks` folder:

```bash
kubectl apply -f ./helm-rbac.yaml
```

Then install Tiller:

```bash
helm init --service-account tiller
```

*Note: If you are installing Helm in a Linux ARM32v7 cluster, run this script instead (adding your desired Helm version):*

```bash
helm init --service-account tiller --tiller-image azureiotedge/tiller:HELM_VERSION-linux-arm32v7
```

## Install the Edge Helm Chart

The Edge Helm chart creates two important pods: **Edge Security Deamon (iotedged)** and the **Edge Agent**. Add the Edge helm repository to your Helm CLI:

```bash
helm repo add edgek8s https://edgek8s.blob.core.windows.net/helm/
```

Now open the `deploy-edge-helm.sh` script located in `scripts/iot-hub` folder in a text editor and update variables:

```sh
# Variables
keyvault_name="your_keyvault_name"
device_prefix="gateway"
```

Then run the script:

```sh
./deploy-edge-helm.sh
```

***Important**: Note that this deploys iotedged in "QuickStart" mode which means that iotedged will use a self-signed device CA cert for generating server and identity certificates. This device CA cert expires after 90 days.*

*Also, this will cause iotedged to use the container file system to store the certificate files and the master encryption key. This will not work very well in case the iotedged pod gets re-created by Kubernetes as it will end up generating brand new certificates and encryption keys thereby disabling all existing modules. Please see the section titled **"Persistent storage for iotedged"** to learn how this can be dealt with.*

## Next Steps

At this point your Kubernetes cluster is ready to receive Edge deployments. In the next step we are going to deploy edge agent modules: [Deploy Edge modules](./deploy-edge-modules.md)
