FROM debian:latest
MAINTAINER Ondrej Vasko

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update 
RUN apt-get install -y postfix supervisor syslog-ng syslog-ng-core

RUN sed -i -E 's/^(\s*)system\(\);/\1unix-stream("\/dev\/log");/' /etc/syslog-ng/syslog-ng.conf

#Setup postfix chroot environment
RUN cp -Rf /etc/host.conf /etc/hosts /etc/localtime /etc/nsswitch.conf /etc/resolv.conf /etc/services /etc/ssl /var/spool/postfix/etc/
ADD install.sh /opt/install.sh
RUN chmod +x /opt/install.sh

CMD /opt/install.sh; /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf