#!/bin/sh

docker build --rm -t httpd-client /root/client/

docker run -ti -d --name client --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro httpd-client

# need to be loged in to docker (using docker-hub account)!
# docker push httpd-client
