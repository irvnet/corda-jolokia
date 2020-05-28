

## Create a network for 2 nodes and a notary

There are several options for building a corda network
1. Creating a simple network for testing with the [network bootstrapper](https://docs.corda.net/docs/corda-enterprise/4.4/network-bootstrapper.html) utility
2. Joining a public network like [Testnet](https://docs.corda.net/docs/corda-enterprise/4.4/network/corda-testnet-intro.html) or the production [Corda Network](https://corda.network/)
3. Building a private network using [Corda Enterprise Network Manager](https://docs.corda.net/docs/cenm/1.2.html).

This tutorial will build a simple test network that can run on a developers desktop, or on a cloud-based virtual machine. To build our test network, we will use the Corda Bootstrapper Utility.


### Create a work area for the 2 nodes and notary
```
{
mkdir ${HOME}/network
cd ${HOME}/network
}
```

### Create a configuration file for the notary in the network directory
The bootstrapper utility will consume the configuration files for the nodes and notary and will generate all of the necessary files to stand up a local network for the nodes to send transctions to each other.

```

cat > notary_node.conf <<EOF
p2pAddress="notary:10400"
detectPublicIp=false
rpcSettings {
    address="0.0.0.0:10401"
    adminAddress="0.0.0.0:10402"
}

notary {
  validating = false
}

emailAddress="notary@r3.com"
myLegalName="O=notaryLLC, L=NJ, C=US"

# node won't see the cordapps without this
cordappSignerKeyFingerprintBlacklist = []

# enable crash shell access
sshd {  port = 4000  }
rpcUsers=[
   {
      username=testuser
      password=password
      permissions=[ALL]
   }
]
devMode=true

EOF

```



### Create a configuration file for Andrea's node in the network directory
```

cat > andrea_node.conf <<EOF
p2pAddress="andrea:10200"
detectPublicIp=false
rpcSettings {
    address="0.0.0.0:10201"
    adminAddress="0.0.0.0:10202"
}

emailAddress="andrea@r3.com"
myLegalName="O=AndreaLLC, L=NJ, C=US"

# node won't see the cordapps without this
cordappSignerKeyFingerprintBlacklist = []

# enable crash shell access
sshd {  port = 2000  }
rpcUsers=[
   {
      username=testuser
      password=password
      permissions=[ALL]
   }
]

devMode=true

EOF

```





### Create a configuration file for Barbara's node in the network directory
```

cat > barbara_node.conf <<EOF
p2pAddress="barbara:10300"
detectPublicIp=false
rpcSettings {
    address="0.0.0.0:10301"
    adminAddress="0.0.0.0:10302"
}

emailAddress="barbara@r3.com"
myLegalName="O=BarbaraLLC, L=NJ, C=US"

# node won't see the cordapps without this
cordappSignerKeyFingerprintBlacklist = []

# enable crash shell access
sshd {  port = 3000  }
rpcUsers=[
   {
      username=testuser
      password=password
      permissions=[ALL]
   }
]

devMode=true

EOF

```



### Bootstrap the network with the Corda Open Source network bootstrapper
For the purpose of this exercise, we'll use Corda Open Source to simplify access to binaries... however in practice, it works the same with Corda Enterprise. The only difference, depending on what's used for a database, may be that you'll need a database block when using enterprise.

Download the [Corda Network Bootstrapper](https://docs.corda.net/docs/corda-os/4.4/network-bootstrapper.html#test-deployments) jar file to the target machine
```
{
cd ${HOME}/network/
curl -O https://software.r3.com/artifactory/corda-releases/net/corda/corda-tools-network-bootstrapper/4.4/corda-tools-network-bootstrapper-4.4.jar
mv corda-tools-network-bootstrapper-4.4.jar bootstrapper.jar
java -jar bootstrapper.jar -V
}
```

### Run the bootstrapper to generate all the necessary network artifacts
```
java -jar bootstrapper.jar --dir .
```

### Start the notary and check the [logs](https://docs.corda.net/docs/corda-os/4.4/node-administration.html#logging)
Note: starting the node with 'nohup' and '&' at the end will start the process in the background. The output that normally goes to stdout will appear in <node-install-dir>/nohup.out. Additionally <node-install-dir>/process-id will capture the nodes process id. 
```
{
cd ${HOME}/network/notary
nohup java -jar corda.jar &
tail logs/node-{hostname}.log
}
```


### Start Andrea's node and check the logs
```
{
cd ${HOME}/network/andrea
nohup java -jar corda.jar &
tail logs/node-{hostname}.log
}
```

### Start Barbara's node and check the logs
```
{
cd ${HOME}/network/barbara
nohup java -jar corda.jar &
tail logs/node-{hostname}.log
}
```

---

## Validate that the network is working properly

  
### Connect to Barbara's administrative console
Login using username= "testuser" and password= "password"
```
ssh testuser@localhost -p 3000
```

### Review nodes available on the network

```
>>> run getNetworkmapSnapshot

0>>> run networkMapSnapshot
- addresses:
  - "barbara:10300"
  legalIdentitiesAndCerts:
  - "O=BarbaraLLC, L=NJ, C=US"
  platformVersion: 6
  serial: 1588975664706
- addresses:
  - "andrea:10200"
  legalIdentitiesAndCerts:
  - "O=AndreaLLC, L=NJ, C=US"
  platformVersion: 6
  serial: 1588975681716
- addresses:
  - "notary:10400"
  legalIdentitiesAndCerts:
  - "O=notaryLLC, L=NJ, C=US"
  platformVersion: 6
  serial: 1588975663824

```
The node should respond by showing the list of nodes on the network... including nodes for Andrea, Barbara and a notary.

### Shutdown the node
```
>>> run gracefulShutdown
```



Congratulations! - you have successfully provisioned a bootstrapped Corda network with 2 nodes and a notary!

---

Next: [Configure the Jolokia Driver](./03-configure-jolokia.md)
