FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

EXPOSE 9000/tcp

# See https://wiki.alpinelinux.org/wiki/WordPress
RUN apk add php7-fpm php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

WORKDIR /var/www

ADD https://wordpress.org/wordpress-5.7.2.tar.gz wordpress.tar.gz
RUN tar -xzvf wordpress.tar.gz && rm wordpress.tar.gz

COPY www.conf /etc/php7/php-fpm.d/www.conf

COPY wp-config.php /var/www/wordpress/wp-config.php 

ENTRYPOINT php-fpm7 -F -R
