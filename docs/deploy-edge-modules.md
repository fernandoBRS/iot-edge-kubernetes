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

## Build and deploy the image to Container Registry

Sign in to Docker by entering your Container Registry credentials:

```sh
docker login -u <ACR username> -p <ACR password> <ACR login server>
```

Access your module folder (if you're using the sample available in this repo, the path is `src/EdgeSolution/modules/SampleModule`)  and build the image:

```sh
docker build -t <REGISTRY_NAME>.azurecr.io/<MODULE_NAME>:0.0.1-amd64 .
```

Then push the image to Container Registry:

```sh
docker push <REGISTRY_NAME>.azurecr.io/<MODULE_NAME>:0.0.1-amd64
```

*Note: If you want to build and push the Edge module image through Visual Studio Code, follow the tutorial described [here](https://docs.microsoft.com/en-us/azure/iot-edge/tutorial-csharp-module#deploy-and-run-the-solution).*

## Deploy the solution

You can follow the tutorial described [here](https://docs.microsoft.com/en-us/azure/iot-edge/tutorial-csharp-module#build-your-iot-edge-solution) to deploy your solution on Visual Studio Code.
