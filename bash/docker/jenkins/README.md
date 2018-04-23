#CleanUp

docker ps -a

docker stop <container ids or tags>

docker rm <container ids or tags>

docker images
docker rmi imageids -f


Option 1)-> For Jenkins on port 8080 and slave on port 50000

docker build -t jenkins . --no-cache --tag  jenkins:2.107.1


Option 2)-> For Jenkins on port 9080 and slave on port 59000 - another Jenkins instance

#Create plugins.txt - using some existing Jenkins instance

export JENKINS_URL=http://<jenkins_domain>
curl -sSL "$JENKINS_URL/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'

#Remove CRLF from plugins.txt
tr -d '\r' < plugins.txt > plugins2.txt

docker build . --file DockerfileJenkinWizard --tag jenkinsw:2.107.1 --no-cache --rm
docker build . --file DockerfilePlugins --tag jenkinsw:2.107.1 --no-cache --rm

Option3)-> Pull from dockerhub
docker login
docker pull ankur07garg/personal_demo:jenkinsw_AutoNoWizardInstallWithPlugins

After above steps, run ./startJenkins.sh or ./startJenkinswizard.sh from bash folder (2 levels up)
