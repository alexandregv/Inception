FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

# dockerize setup
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# See https://wiki.alpinelinux.org/wiki/FTP#vsftpd
RUN apk add vsftpd=3.0.3-r6 openssl=1.1.1k-r0

COPY vsftpd.conf.tmpl /etc/vsftpd/vsftpd.conf.tmpl

# We use root and not vsftp user because it is strongly discouraged by the docs
# See 'run_as_launching_user' option in man 5 vsftpd.conf (https://man.archlinux.org/man/vsftpd.conf.5)
USER root

EXPOSE 21/tcp

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
