FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

# dockerize setup
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# See https://wiki.alpinelinux.org/wiki/Nginx#Installation
RUN apk add nginx=1.18.0-r1 openssl=1.1.1k-r0
RUN adduser -D -g 'www' www && \
	mkdir -p /var/www /var/run/nginx /etc/nginx/ssl && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/log/nginx && \
	chown -R www:www /var/run/nginx && \
	chown -R www:www /etc/nginx/ssl && \
	chown -R www:www /etc/nginx/conf.d && \
	chown -R www:www /var/www

USER www

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY nginx.conf /etc/nginx/nginx.conf
COPY proxy.conf /etc/nginx/proxy.conf
COPY default.conf.tmpl /etc/nginx/conf.d/default.conf.tmpl

WORKDIR /var/www

EXPOSE 443/tcp 443/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
