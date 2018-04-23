docker create --name jenkinsw-data jenkinsw:2.107.1
docker run -d \
          --volumes-from jenkinsw-data \
          --name jenkinsw \
          -p 9080:8080 \
          jenkinsw:2.107.1

         # --link xld \
         # --link xlr \
