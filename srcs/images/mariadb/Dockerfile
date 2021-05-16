FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

# dockerize setup
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# mariadb setup
RUN apk add mariadb mariadb-client
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb-server.cnf

# SQL seed template (for dockerize)
COPY seed.sql.tmpl /seed.sql.tmpl

COPY docker-entrypoint.sh /docker-entrypoint.sh

USER mysql

EXPOSE 3306

ENTRYPOINT ["/docker-entrypoint.sh"]
