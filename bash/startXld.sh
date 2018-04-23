docker create --name xld-data adejonge/xld
docker run -d \
          --volumes-from xld-data \
          --name xld \
          -p 4516:4516 \
          --link wildfly-qa \
          --link wildfly-pr \
          --link mocha \
          adejonge/xld
