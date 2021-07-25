FROM local/c7-systemd
RUN mv /etc/yum.repos.d/*.repo /tmp/
RUN touch /etc/yum.repos.d/remote.repo
RUN echo $'[remote]\nname=remote_repo\nbaseurl=http://172.17.0.3\nenabled=1\ngpgcheck=0' > /etc/yum.repos.d/remote.repo
RUN yum -y install httpd

CMD ["/usr/sbin/init"]
