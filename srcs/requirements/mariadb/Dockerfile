FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

RUN apk add mariadb mariadb-client

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

USER mysql

EXPOSE 3306

ENTRYPOINT mariadbd --user=mysql --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock
