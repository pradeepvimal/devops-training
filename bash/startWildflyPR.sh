docker create --name wildfly-pr-data adejonge/wildfly
docker run -d \
          --volumes-from wildfly-pr-data \
          --name wildfly-pr \
          -p 1122:22 -p 8082:8081 \
          adejonge/wildfly
