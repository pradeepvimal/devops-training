FROM ubuntu:wily

ADD myfile-delete.rb /root/myfile-delete.rb
ADD myfile.rb /root/myfile.rb
ADD webserver-full.rb /root/webserver-full.rb
ADD webserver-plain.rb /root/webserver-plain.rb


RUN apt-get update 
RUN apt-get install -y curl vim
RUN curl -L https://www.opscode.com/chef/install.sh | bash

WORKDIR /root
