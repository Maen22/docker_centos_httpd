#!/bin/sh

docker build --rm -t httpd-repo-server /root/server/

docker run -ti -d --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8899:80 httpd-repo-server

# need to be loged in to docker (using docker-hub account)!
# docker push httpd-repo-server


