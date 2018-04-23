./setValues.sh
sed -e "s/\${datadog}/${DATADOG##*/}/" dd-agent.template > dd-agent@.service
sed -e "s/\${papertrail}/${PAPERTRAIL##*/}/" logspout.template > logspout@.service
./startAll.sh
