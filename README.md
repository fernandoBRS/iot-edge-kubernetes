# Azure IoT Edge on Kubernetes: High Availability on Edge Computing

Edge devices are often used as [gateways](https://docs.microsoft.com/en-us/azure/iot-edge/iot-edge-as-gateway) to serve as a point of aggregation and compute for other devices/sensors. Configuring and managing gateway devices is challenging in systems that require high availability due the fact they tend to be a single point of failure.

**Azure IoT Edge on Kubernetes** allows us to introduce some redundancy at the gateway layer so that workloads can be migrated over to another gateway device in the event of a complete device failure.