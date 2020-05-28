# Configuring a Corda node for metrics with Jolokia  
This tutorial walks you through configuring Jolokia to make JMX metrics available from a Corda node, and to use Hawtio to view the available metrics.


This tutorial is not for readers looking for a fully automated solution... though some scripts are available in this repo to simply provisioning a vm for testing purposes, the content is primarily intended for learning the basics of how to extract metrics from a Corda node using Jolokia and viewing the metrics with a Hawtio.

---

## Target Audience
The intended audience for this tutorial is someone configuring a Corda node to obtain metrics and test the configuration by viewing the available metrics in a simple viewer. 


---
## Environment Details
For this exercise you will need:
- Ubuntu 18.04 vm with a minimum of 2vcpu and 4gb memory
- Access to Azure with a authorization to create an vm's
- Corda Enterprise Bootstrapper (tested with CE v4.4)
- Jolokia JVM Agent (tested with v1.6.1)
- Hawtio jar file (tested with v2.10 )

---
## Outline

- [Prepare a virtual machine](./docs/01-provision-vm.md)
- [Bootstrap a Network](./docs/02-bootstrap-a-network.md)
- [Configure the Jolokia Driver](./docs/03-configure-jolokia.md)
- [Configure Hawtio to view node metrics](./docs/04-configure-hawtio.md)






