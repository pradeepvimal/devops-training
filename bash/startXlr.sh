docker create --name xlr-data adejonge/xlr
docker run -d \
          --volumes-from xlr-data \
          --name xlr \
          -p 5516:5516 \
          --link xld \
          --link mocha \
          --link wildfly-qa \
          --link wildfly-pr \
          adejonge/xlr
