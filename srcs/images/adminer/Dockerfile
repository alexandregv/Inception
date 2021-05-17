FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

# php + php-fpm setup for adminer
RUN apk add php7 php7-phar php7-fpm php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

# adminer setup
ENV ADMINER_VERSION=4.8.1
ADD https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php /var/www/adminer/index.php

# user setup
RUN adduser -D -g 'adminer' adminer && \
	mkdir -p /var/www/adminer && \
	chown -R adminer:adminer /var/www/adminer && \
	chown -R adminer:adminer /var/log/php7
USER adminer

# custom adminer theme
ADD --chown=adminer https://raw.githubusercontent.com/Niyko/Hydra-Dark-Theme-for-Adminer/master/adminer.css /var/www/adminer/adminer.css

# copy and test php-fpm conf
COPY www.conf /etc/php7/php-fpm.d/www.conf
RUN php-fpm7 --test

WORKDIR /var/www/adminer

EXPOSE 9000/tcp

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
