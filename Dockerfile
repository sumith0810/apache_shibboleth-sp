FROM ubuntu:latest
MAINTAINER Sumith Waghmare

RUN \
  apt-get update && \
  apt-get install -y wget apache2 libapache2-mod-shib2

  
COPY  reverseProxy.conf /etc/apache2/sites-enabled/
COPY  shibboleth2.xml /etc/shibboleth/shibboleth2.xml
   


RUN a2enmod proxy proxy_http rewrite ssl

COPY  configure.sh /configure.sh

RUN chmod 755 /configure.sh


CMD /configure.sh ; sleep infinity

EXPOSE 80 443

