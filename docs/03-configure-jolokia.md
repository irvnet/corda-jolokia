

---

## Install Jolokia to the nodes to obtain metrics

### Download the jolokia jar file to the network directory

```
{
cd ${HOME}/network/
curl -O https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.1/jolokia-jvm-1.6.1-agent.jar
mv jolokia-jvm-1.6.1-agent.jar jolokia-agent.jar
}
```

### Add the Jolokia driver to each of the nodes
```
{
for nodename in notary andrea barbara; do
    mkdir -p ${HOME}/network/${nodename}/drivers
    cp jolokia-agent.jar ${HOME}/network/${nodename}/drivers
done
}
```

### Restart each of the nodes 

Start each node in the background with a different port for the Jolokia endpoint. Check the log for each node to ensure there are no errors.
```
{
cd ${HOME}/network/andrea
nohup java -Dcapsule.jvm.args="-javaagent:drivers/jolokia-agent.jar=port=12009,host=localhost" -jar corda.jar &

cd ${HOME}/network/barbara
nohup java -Dcapsule.jvm.args="-javaagent:drivers/jolokia-agent.jar=port=13009,host=localhost" -jar corda.jar &

cd ${HOME}/network/notary
nohup java -Dcapsule.jvm.args="-javaagent:drivers/jolokia-agent.jar=port=14009,host=localhost" -jar corda.jar &
}
```

### Check the output of the nodes for the Jolokia endpoint
To find the endpoint for Jolokia, check the output file 'nohup.out' for each node.
```
$: cd ${HOME}/network/andrea
$: grep -i "agent started" nohup.out
Jolokia: Agent started with URL http://127.0.0.1:12009/jolokia/
```

### Check to see that the endpoint on each node is working
```
$: curl http://127.0.0.1:12009/jolokia/
{"request":{"type":"version"},"value":{"agent":"1.6.1","protocol":"7.2","config":{"listenForHttpService":"true","maxCollectionSize":"0","authIgnoreCerts":"false","agentId":"12.0.0.4-24750-9807454-jvm","debug":"false","agentType":"jvm","policyLocation":"classpath:\/jolokia-access.xml","agentContext":"\/jolokia","serializeException":"false","mimeType":"text\/plain","maxDepth":"15","authMode":"basic","authMatch":"any","discoveryEnabled":"true","streaming":"true","canonicalNaming":"true","historyMaxEntries":"10","allowErrorDetails":"true","allowDnsReverseLookup":"true","realm":"jolokia","includeStackTrace":"true","maxObjects":"0","useRestrictorService":"false","debugMaxEntries":"100"},"info":{}},"timestamp":1588988735,"status":200}

```

You have successfully installed Jolokia on the nodes.

---

Next: [Configure Hawtio to view node metrics](./04-configure-hawtio.md)


