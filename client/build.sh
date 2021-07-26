#!/bin/sh

docker build --rm -t maen22/httpd-client . 

docker run -ti -d --name client --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro maen22/httpd-client

# need to be loged in to docker (using docker-hub account)!
# docker push maen22/httpd-client
