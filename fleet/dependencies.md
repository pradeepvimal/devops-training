# Dependencies:

dd-agent -> logspout
wildfly-pr -> dd-agent
wildfly-qa -> wildfly-pr
mocha -> wildfly-qa
xld -> mocha
xlr -> xld
jenkins -> xlr
