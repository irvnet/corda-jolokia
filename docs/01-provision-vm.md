# Building a virtual-machine based Corda test environment

This tutorial is cloud agnostic... and assumes the reader is familiar with managing cloud-based virtual machines and the Linux operating system... as such, background material that covers cloud concepts and provisioning virtual machines will not be included here.  Fortunately lots of great documentation is available to assist with working on your desired cloud:

- [Provisioning a linux server on Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal)
- [Provisioning a linux server on AWS](https://docs.aws.amazon.com/quickstarts/latest/vmlaunch/welcome.html)
- [Provisioning a linux server on Google Cloud Platform](https://cloud.google.com/compute/docs/quickstart-linux)

---

System Requirements:

Virtual Machine:
- Operating system: Ubuntu 18.04 LTS
- CPU: 2
- Memory: 4GB

Required Software:
- Azul Java JDK [v1.8](https://cdn.azul.com/zulu/bin/zulu8.44.0.11-ca-jdk8.0.242-linux_x64.tar.gz)
- Network Bootstrapper v4.4 (Corda Enterprise)
- Jolokia JVM agent [v1.6.1](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.1/jolokia-jvm-1.6.1-agent.jar)
- Hawtio web application [v2.10](https://repo1.maven.org/maven2/io/hawt/hawtio-app/2.10.0/hawtio-app-2.10.0.jar)


---

## Prepare the provisioned vm with the required software

### Update the packages on the vm
```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install curl -y
```

### Install azul jdk
```
{
curl -O https://cdn.azul.com/zulu/bin/zulu8.44.0.11-ca-jdk8.0.242-linux_x64.tar.gz
tar -zxvf zulu8.44.0.11-ca-jdk8.0.242-linux_x64.tar.gz
sudo cp -r zulu8.44.0.11-ca-jdk8.0.242-linux_x64 /usr/local/bin/zulu
export PATH=/usr/local/bin/zulu/bin:$PATH
java -version
}
```

---

Next: [Bootstrap a Network](./02-bootstrap-a-network.md)

