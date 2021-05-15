FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

EXPOSE 80/tcp 80/udp 443/tcp 443/udp

# See https://wiki.alpinelinux.org/wiki/Nginx#Installation
RUN apk add nginx=1.18.0-r1
RUN adduser -D -g 'www' www && \
	mkdir -p /www /var/run/nginx && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/log/nginx && \
	chown -R www:www /var/run/nginx && \
	chown -R www:www /www

USER www

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker-entrypoint.sh"]
