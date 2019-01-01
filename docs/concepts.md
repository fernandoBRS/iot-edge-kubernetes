# Concepts

## Edge Namespace

Considering the scenario where you already have a Kubernetes cluster with workloads running, all IoT Edge resources runs in a different namespace called `microsoft-azure-devices-edge`.

## Edge modules

Edge modules are the smallest unit of computation managed by IoT Edge, and can contain Azure services (such as Azure Stream Analytics or Coognitive Service) or your own solution-specific code. For more detail about the pieces that make up a module you can find [here](https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-modules).

From the Kubernetes perspective, each module runs as a pod. You can implement your own custom module exactly the same way you develop common Edge modules, there is no distinction between common modules and modules that run on Kubernetes. This is only possible because **Edge Agent** (described below) takes care of translating deployments to Kubernetes.

## Edge Security Deamon (iotedged)

The Edge Security Deamon – also known as **iotedged** – provides an abstraction over [Hardware Security Modules (HSMs)](https://en.wikipedia.org/wiki/Hardware_security_module), enabling secure SAS tokens and certificates provisioning for IoT Edge modules. 

The iotedged runs as a normal Kubernetes pod, exposed as a service using TLS over TCP. 
The service type is defined as [ClusterIP](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types), which means it's available only to workloads running within the namespace (which basically boils down to other Edge modules).

## Edge Runtime

The Edge runtime is responsible for providing module management and communication between edge devices and IoT Hub. These roles are performed by two components: **Edge Agent** and **Edge Hub**. The concept behing the runtime on Kubernetes is exactly the same as the common edge runtime and you can find detailed info [here](https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-runtime).

## Edge Agent

The Edge Agent is responsible for translating Edge deployments into Kubernetes deployments. It enables developers to easily migrate existing Edge modules and implement new modules in the same way they are used to.

During deployment it performs the necessary translation of module parameters such as environment variables and container `createOptions` (one of the [Edge agent desired properties](https://docs.microsoft.com/en-us/azure/iot-edge/module-edgeagent-edgehub#edgeagent-desired-properties)) into the equivalent pod constructs. 

The agent is a [Kubernetes operator](https://coreos.com/blog/introducing-operators.html), an IoT Edge controller that extends the Kubernetes API to manage Edge deployments through a [Custom Resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) definition.

## Edge Hub

The Edge Hub is a module that acts as a local proxy for IoT Hub by exposing the same protocol endpoints as IoT Hub, which means that clients (whether devices or modules) can connect to the IoT Edge runtime just as they would to IoT Hub. 
From the Kubernetes perspective, it runs as a pod. If you want more info about the Edge Hub, you can find more details [here](https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-runtime#iot-edge-hub).