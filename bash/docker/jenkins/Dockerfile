FROM jenkins:latest

FROM java:8u45-jdk

RUN apt-get update && apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/jenkins_home

# Jenkins is ran with user `jenkins`, uid = 1000
# If you bind mount a volume from host/vloume from a data container, 
# ensure you use same uid
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

# Jenkins home directoy is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want 
# to set on a fresh new installation. Use it to bundle additional plugins 
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d


COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

#ENV JENKINS_VERSION 1.609.1
#ENV JENKINS_SHA 698284ad950bd663c783e99bc8045ca1c9f92159

#----
#Changes Ankur for latest jenkins version which is 2.107.1
ENV JENKINS_VERSION 2.107.1
#http://mirrors.jenkins-ci.org/war-stable/2.107.1/jenkins.war.sha256 - link for Sha
ENV JENKINS_SHA cec74c80190ed1f6ce55d705d2f649ddb2eaf8aba3ae26796152921d46b31280

# Skip initial setup.
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false" \
    JENKINS_USER=admin \
    JENKINS_PASS=admin \
    JENKINS_EMAIL=admin@localhost 
    # Customizable settings:
    # Default admin user.
    # Default email.
    # Default URL.
    # This is necessary because Jenkins cannot reliably detect such a URL from within itself.
#    JENKINS_URL=http://192.168.64.100:8080/



#-----

# could use ADD but this one does not check Last-Modified header 
# see https://github.com/docker/docker/issues/8331
#RUN curl -fL http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
 # && echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha1sum -c -

RUN curl -fL http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha256sum -c -

ENV JENKINS_UC https://updates.jenkins-ci.org
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

ENV COPY_REFERENCE_FILE_LOG /var/log/copy_reference_file.log
RUN touch $COPY_REFERENCE_FILE_LOG && chown jenkins.jenkins $COPY_REFERENCE_FILE_LOG

#USER jenkins

COPY jenkins.sh /usr/local/bin/jenkins.sh
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

# from a derived Dockerfile, can use `RUN plugin.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh
COPY plugins2.txt /usr/share/jenkins/ref/plugins2.txt

ENV MAVEN_VERSION 3.3.3

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins2.txt
