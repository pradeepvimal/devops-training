docker run -d --privileged --name dd-agent -h hostname \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /proc/mounts:/host/proc/mounts:ro \
-v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
-e API_KEY=$DATADOG \
datadog/docker-dd-agent
