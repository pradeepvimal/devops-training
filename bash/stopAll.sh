export CONTAINERS=jenkins xld xlr wildfly-qa wildfly-pr
docker stop $CONTAINERS
docker rm $CONTAINERS
