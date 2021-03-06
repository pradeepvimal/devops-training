#! /bin/bash

# Parse a support-core plugin -style txt file as specification for jenkins plugins to be installed
# in the reference directory, so user can define a derived Docker image with just :
#
#FROM jenkins
#COPY plugins.txt /plugins.txt
#RUN /usr/local/bin/plugins.sh /plugins.txt
#

set -e

REF=/usr/share/jenkins/ref/plugins
mkdir -p $REF

while read spec || [ -n "$spec" ]; do
    plugin=(${spec//:/ });
    [[ ${plugin[0]} =~ ^# ]] && continue
    [[ ${plugin[0]} =~ ^\s*$ ]] && continue
    [[ -z ${plugin[1]} ]] && plugin[1]="latest"
    echo "Downloading ${plugin[0]}:${plugin[1]}"

    if [ -z "$JENKINS_UC_DOWNLOAD" ]; then
      JENKINS_UC_DOWNLOAD=$JENKINS_UC/download
    fi
#echo "---echoing download plugin   curl -sSL -f "${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi" -o "$REF/${plugin[0]}.jpi""  >> $COPY_REFERENCE_FILE_LOG 
#    curl -sSL -f "${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi" -o "$REF/${plugin[0]}.jpi"
#echo "--echoing curl --retry 3 --retry-delay 5 -sSL -f \"${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi\" -o \"$REF/${plugin[0]}.jpi\"" >> $COPY_REFERENCE_FILE_LOG
#echo "--echoing curl --retry 3 --retry-delay 5 -sSL -f \"${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi\" -o \"$REF/${plugin[0]}.jpi\"" 

#printf %s "$JENKINS_UC_DOWNLOAD" | xxd
JENKINS_UC_DOWNLOAD=${JENKINS_UC_DOWNLOAD%$'\r'}
URL=${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi

echo "url=$URL"
#${plugin[1]} = ${plugin[1]%$'\r'}
URL=${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi



curl --retry 3 --retry-delay 5 -sSL -f "${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi" -o "$REF/${plugin[0]}.jpi"

done  < $1
