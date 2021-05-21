#!/bin/sh

dockerize -template /etc/nginx/conf.d/default.conf.tmpl:/etc/nginx/conf.d/default.conf

#if [ ! -f /etc/nginx/ssl/certificate.crt ] || [ ! -f /etc/nginx/ssl/private.key ]; then
#	rm -f /etc/nginx/ssl/certificate.crt /etc/nginx/ssl/private.key 
#	echo "Generating SSL certificate..."
#	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout /etc/nginx/ssl/private.key -out /etc/nginx/ssl/certificate.crt -subj "/CN=$DOMAIN_NAME" -addext "subjectAltName=DNS:$DOMAIN_NAME,DNS:$DOMAIN_NAME"
#fi

# Make sure logfiles exist
touch /var/log/nginx/access.log /var/log/nginx/error.log

nginx -t -v
exec dockerize -stdout /var/log/nginx/access.log -stdout /var/log/nginx/error.log nginx -g "daemon off;" $@
