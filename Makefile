NAME=inception
DC=docker-compose -f srcs/docker-compose.yaml -p ${NAME}

# general 
all: build run

run: upd logsf

build:
	${DC} build

up:
	${DC} up

upd:
	${DC} up -d

ps:
	${DC} ps

logs:
	${DC} logs

logsf:
	${DC} logs -f

start:
	${DC} start

stop:
	${DC} stop

down:
	${DC} down

clean:
	${DC} down
	if [ -n "$$(${DC} images -q)" ]; then docker image rm $$(${DC} images -q); fi

fclean:
	${DC} down -v
	if [ -n "$$(${DC} images -q)" ]; then docker image rm $$(${DC} images -q); fi


# mariadb
mariadb.build:
	${DC} build mariadb

mariadb.logs:
	${DC} logs mariadb

mariadb.logsf:
	${DC} logs -f mariadb

mariadb.up:
	${DC} up mariadb

mariadb.upd:
	${DC} up -d mariadb

mariadb.start:
	${DC} start mariadb

mariadb.stop:
	${DC} stop mariadb

mariadb.kill:
	${DC} kill mariadb

mariadb.rm:
	${DC} rm -f mariadb

mariadb.down: mariadb.stop mariadb.rm

mariadb.shell:
	${DC} exec mariadb sh

mariadb.client:
	${DC} exec mariadb mariadb --socket=/var/lib/mysql/mysql.sock


# nginx
nginx.build:
	${DC} build nginx

nginx.logs:
	${DC} logs nginx

nginx.logsf:
	${DC} logs -f nginx

nginx.up:
	${DC} up nginx

nginx.upd:
	${DC} up -d nginx

nginx.start:
	${DC} start nginx

nginx.stop:
	${DC} stop nginx

nginx.kill:
	${DC} kill nginx

nginx.rm:
	${DC} rm -f nginx

nginx.down: nginx.stop nginx.rm

nginx.shell:
	${DC} exec nginx sh
