FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

# dockerize setup
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# php + php-fom setup for wordpress (see https://wiki.alpinelinux.org/wiki/WordPress)
RUN apk add php7 php7-phar php7-fpm php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

# wp-cli setup
ADD https://github.com/wp-cli/wp-cli/releases/download/v2.4.0/wp-cli-2.4.0.phar /usr/bin/wp-cli
RUN chmod a+rx /usr/bin/wp-cli

# user setup
RUN adduser -D -g 'wordpress' wordpress && \
	mkdir -p /var/www/wordpress && \
	chown -R wordpress:wordpress /var/www/wordpress && \
	chown -R wordpress:wordpress /var/log/php7
USER wordpress

# wordpress download
RUN wp-cli core download --version=5.7.2 --path=/var/www/wordpress --locale=en_US --color

# php-fpm conf
COPY www.conf /etc/php7/php-fpm.d/www.conf

# wordpress config (fetches env vars)
COPY wp-config.php /var/www/wordpress/wp-config.php 

WORKDIR /var/www/wordpress

EXPOSE 9000/tcp

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
