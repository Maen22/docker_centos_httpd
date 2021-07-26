FROM local/c7-systemd

RUN yum -y install httpd; \ 
	yum clean all; \ 
	systemctl enable httpd.service; \
	yum -y install createrepo; \ 
	yum -y install yum-utils;

RUN mkdir -p /var/www/html/repos/local

RUN cd /var/www/html/repos/local && repotrack httpd

RUN createrepo /var/www/html

EXPOSE 80

CMD ["/usr/sbin/init"]

