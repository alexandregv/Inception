#!/bin/sh

dockerize -template /etc/nginx/conf.d/default.conf.tmpl:/etc/nginx/conf.d/default.conf

#if [ ! -f /etc/nginx/ssl/cert.crt ] || [ ! -f /etc/nginx/ssl/private.key ]; then
#	rm -f /etc/nginx/ssl/cert.crt /etc/nginx/ssl/private.key 
#	echo "Generating SSL certificate..."
#	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout /etc/nginx/ssl/private.key -out /etc/nginx/ssl/cert.crt -subj "/CN=aguiot--.42.fr" -addext "subjectAltName=DNS:aguiot--.42.fr,DNS:aguiot--.42.fr"
#fi

# Make sure logfiles exist
touch /var/log/nginx/access.log /var/log/nginx/error.log

nginx -t -v
exec dockerize -stdout /var/log/nginx/access.log -stdout /var/log/nginx/error.log nginx -g "daemon off;" $@
