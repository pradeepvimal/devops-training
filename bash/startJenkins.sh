docker create --name jenkins-data jenkins:2.107.1
docker run -d \
          --volumes-from jenkins-data \
          --name jenkins \
          -p 8080:8080 \
          jenkins:2.107.1

         # --link xld \
         # --link xlr \
