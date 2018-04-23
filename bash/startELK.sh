docker stop logspout kibana logstash es
docker rm logspout kibana logstash es
docker run -d \
    -p 9200:9200 \
    -p 9300:9300 \
    --name es \
    elasticsearch
docker run -d \
    -p 5000:5000 \
    -p 5000:5000/udp \
    -v $(pwd)/logstash/logstash.conf:/etc/logstash.conf \
    --link es:elasticsearch \
    --name logstash \
    logstash -f /etc/logstash.conf
export LOGSTASH=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' logstash)
docker run -d \
    -p 5601:5601 \
    --link es:elasticsearch \
    --name kibana \
    kibana
echo $LOGSTASH
docker run -d \
    -v=/var/run/docker.sock:/tmp/docker.sock \
    --name logspout \
    progrium/logspout:master syslog://$LOGSTASH:5000

