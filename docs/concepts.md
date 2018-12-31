# Concepts

<!-- ## Edge Runtime Topology

TODO -->

## Edge Namespace

Considering the scenario where you already have a Kubernetes cluster with workloads running, all IoT Edge resources runs in a different namespace called `microsoft-azure-devices-edge`.

## Edge Security Deamon (iotedged)

The Edge Security Deamon – also known as **iotedged** – provides an abstraction over [Hardware Security Modules (HSMs)](https://en.wikipedia.org/wiki/Hardware_security_module), enabling secure SAS tokens and certificates provisioning for IoT Edge modules. 

The iotedged runs as a normal Kubernetes pod, exposed as a service using TLS over TCP. 
The service type is defined as [ClusterIP](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types), which means it's available only to workloads running within the namespace (which basically boils down to other Edge modules).

## Edge Runtime

The Edge runtime is responsible for providing module management and communication between edge devices and IoT Hub. These roles are performed by two components: **Edge Agent** and **Edge Hub**. The concept behing the runtime on Kubernetes is exactly the same as the common edge runtime and you can find detailed info [here](https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-runtime).

## Edge Agent

TODO

## Edge Hub

TODO

## Managing Edge Deployments

TODO