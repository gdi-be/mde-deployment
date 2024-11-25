#!/bin/bash

printf "Updating the SSL certificate\n"

# The Keycloak host, this must be accessible from inside a docker network and run under HTTPS
KEYCLOAK_HOST=$(ip route get 1 | awk '{gsub("^.*src ",""); print $1; exit}')

sed -i -E "s/IP.2    = (.+)/IP.2    = ${KEYCLOAK_HOST}/g" mde-nginx/ssl/localhost.conf

openssl req \
  -config ./mde-nginx/ssl/localhost.conf \
  -addext basicConstraints=critical,CA:TRUE,pathlen:1 \
  -batch \
  -x509 \
  -nodes \
  -days 3650 \
  -newkey rsa:2048 \
  -keyout ./mde-nginx/ssl/private/localhost.key \
  -out ./mde-nginx/ssl/private/localhost.crt

if keytool -list -alias DEV -keystore ./mde-backend/keystore/cacerts -noprompt -storepass changeit > /dev/null 2>&1; then
  keytool -delete -alias DEV -keystore ./mde-backend/keystore/cacerts -noprompt -storepass changeit
fi
keytool -import -file ./mde-nginx/ssl/private/localhost.crt -alias DEV -keystore ./mde-backend/keystore/cacerts -noprompt -storepass changeit
