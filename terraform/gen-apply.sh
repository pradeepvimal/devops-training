export KEY=`curl -w "\n" 'https://discovery.etcd.io/new?size=1'`
sed -e "s/\${i}/1/" -e "s/\${key}/${KEY##*/}/" etcd-cloud-config.template > etcd-cloud-config.yml
terraform apply
