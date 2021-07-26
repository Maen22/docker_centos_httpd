#!/bin/sh

docker build --rm -t maen22/httpd-repo-server . 

docker run -ti -d --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8899:80 maen22/httpd-repo-server

# need to be loged in to docker (using docker-hub account)!
# docker push maen22/httpd-repo-server


