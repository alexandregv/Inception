#!/bin/sh

# Generate SSL cert if not already present
#if [ ! -f /ssl/cert.crt ] || [ ! -f /ssl/private.key ]; then
#	rm -f /ssl/cert.crt /ssl/private.key 
#	echo "Generating SSL certificate..."
#	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout /ssl/private.key -out /ssl/cert.crt -subj "/CN=aguiot--.42.fr" -addext "subjectAltName=DNS:aguiot--.42.fr,DNS:aguiot--.42.fr"
#fi

# Generate vsftpd conf from template
dockerize -template /etc/vsftpd/vsftpd.conf.tmpl:/etc/vsftpd/vsftpd.conf

# Create FTP user
(echo "$FTP_USER"; echo "$FTP_PASS") | adduser -H -g "$FTP_USER" "$FTP_USER"
chmod ug-w "/home/$FTP_USER"
mkdir -p "/home/$FTP_USER/wordpress"
chown -R "$FTP_USER:$FTP_USER" "/home/$FTP_USER/wordpress"
chmod ug+rw "/home/$FTP_USER/wordpress"

# Make sure logfile exist
touch /var/log/vsftpd.log

# Start vsftpd via dockerize, becoming PID 1
exec dockerize -stdout /var/log/vsftpd.log vsftpd /etc/vsftpd/vsftpd.conf
