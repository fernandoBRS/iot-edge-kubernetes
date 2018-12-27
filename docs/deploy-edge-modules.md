# Deploy IoT Edge modules

In this step we are going to create and deploy an IoT Edge module that filters sensor data into the Kubernetes cluster. You can use the Edge module developed in C# available in the `src/EdgeSolution` folder or create one from scratch by following the tutorial described [here](https://docs.microsoft.com/en-us/azure/iot-edge/tutorial-csharp-module).

*Note: It's not mandatory to develop your Edge module in C#. As you can see in the documentation you can develop in different languages like C, Node.js, Python and Java.*

## Update the Edge Agent module image

When you create a new IoT Edge solution, the following image is used by default:

    mcr.microsoft.com/azureiotedge-agent:<IMAGE_VERSION>

That image is the Edge agent that is installed on the edge device, but in our case we need the image that will be installed on the Kubernetes cluster:

    azureiotedge/azureiotedge-agent:<IMAGE_VERSION>

To do that, open the `deployment.template.json` located in your project root folder and find the `edgeAgent` property:

```json
"systemModules": {
    "edgeAgent": {
        "type": "docker",
        "settings": {
            "image": "mcr.microsoft.com/azureiotedge-agent:1.0",
            "createOptions": {}
        }
    },
    ...
}
```

Then update the `image` property by the new image:

```json
"systemModules": {
    "edgeAgent": {
        "type": "docker",
        "settings": {
            "image": "azureiotedge/azureiotedge-agent:0.1.0-alpha",
            "createOptions": {}
        }
    },
    ...
}
```

***Important:** At the time of this writing, the edge agent image is on version **0.1.0-alpha**. Make sure to check if there is a new version available.*   

## Grant Kubernetes access to Azure Container Registry

Before building and deploying the solution make sure your Kubernetes cluster has granted access to your Container Registry, otherwise you will receive the `unauthorized: authentication required` error. If you haven't done that, follow the tutorial described [here](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-aks).

## Build and Deploy the solution

You can follow the tutorial described [here](https://docs.microsoft.com/en-us/azure/iot-edge/tutorial-csharp-module#build-your-iot-edge-solution) to build and deploy your solution on Visual Studio Code.
