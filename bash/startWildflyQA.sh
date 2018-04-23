docker create --name wildfly-qa-data adejonge/wildfly
docker run -d \
          --volumes-from wildfly-qa-data \
          --name wildfly-qa \
          -p 1022:22 -p 8081:8081 \
          adejonge/wildfly
