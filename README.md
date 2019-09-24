# OverView of Apache Shibboleth-sp

This Docker image is Apache2 with Shibboleth SP installed running on Ubuntu.

This image can be used as a base image overriding the configuration with local changes.

Ports 80 and 443 are exposed for traffic.


# Building the Image using Dockerfile

To build the image run below command

User must replace the variables in the configure.sh file with the local config.

The variables that needs to be replaced in the configure.sh file.

After replacing the variables run the below command.

docker build -t <<tag_name>> .

# running the Image using docker-compose.yml

version: '2.2'

volumes:
  couchbase-data:

services:

  Apache_Shib:
    image: ubuntu_shib
    container_name: ubuntu_shib
    build: .
    environment:
      - SERVICE_TO_PROTECT=tomcat
      - SERVICE_PORT=8080
      - HOSTNAME=${your DNS_NAME}
      - IDP_ENTITY_ID=${your IDP_ENTITY_ID}
      - IDP_METADATA_URL=${your IDP_METADATA_URL}
    ports:
      - 80:80
      - 443:443
      
  after pulling the image on the machine just run below command
  
  docker-compose up -d

