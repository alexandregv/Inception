#!/bin/sh

if [ ! -f /ssl/cert.crt ] || [ ! -f /ssl/private.key ]; then
	rm -f /ssl/cert.crt /ssl/private.key 
	echo "Generating SSL certificate..."
	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout /ssl/private.key -out /ssl/cert.crt -subj "/CN=aguiot--.42.fr" -addext "subjectAltName=DNS:aguiot--.42.fr,DNS:aguiot--.42.fr"
fi

# Make sure logfile exist
touch /var/log/vsftpd.log

# Start vsftpd via dockerize, becoming PID 1
exec dockerize -stdout /var/log/vsftpd.log vsftpd /etc/vsftpd/vsftpd.conf
