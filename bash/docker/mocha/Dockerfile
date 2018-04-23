FROM iojs:latest

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

RUN apt-get update && apt-get install -y curl python make vim --no-install-recommends

WORKDIR /root

RUN npm install -g mocha
RUN npm install zombie

CMD /usr/sbin/sshd && bash
