#!/bin/bash

set -x
set -m


echo "Configuring Apache and Shibboleth"

mkdir /etc/apache2/ssl

#create server certificates as per your organisational directory structure.
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/ssl.key -out /etc/apache2/ssl/ssl.crt -subj "/C=${country}/ST=${state}/L=${Location}/O=${Company_Name}/OU=${unit_name}/CN=${Domain_Name}"

#shibboleth key generation

shib-keygen -h ${Domain_Name}

#To download the metadata file from IPD server.

wget --no-check-certificate ${IDP_METADATA_URL} -P /etc/shibboleth/


#update the below configuration files using sed command as per the user.

sed -i "s|SP_ENTITY_ID|https://${Domain_Name}/shibboleth|g" /etc/shibboleth/shibboleth2.xml
sed -i "s|IDP_ENTITY_ID|${IDP_ENTITY_ID}|g" /etc/shibboleth/shibboleth2.xml
sed -i "s|IDP_METADATA_URL|${IDP_METADATA_URL}|g" /etc/shibboleth/shibboleth2.xml
sed -i "s|SERVICE_TO_PROTECT|${SERVICE_TO_PROTECT}|g" /etc/apache2/sites-enabled/reverseProxy.conf
sed -i "s|SERVICE_PORT|${SERVICE_PORT}|g" /etc/apache2/sites-enabled/reverseProxy.conf

#restart the services.

service apache2 restart

service shibd restart

