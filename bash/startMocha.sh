docker create --name mocha-data adejonge/mocha
docker run -d \
          --name mocha \
          -p 1222:22 \
          --link wildfly-qa \
          --link wildfly-pr \
          adejonge/mocha \
          /usr/sbin/sshd -D
