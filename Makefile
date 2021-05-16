NAME=inception
DC=docker-compose -f srcs/docker-compose.yaml -p ${NAME}

# general 
all: build run

run: upd logsf

clean:
	${DC} down -v
	if [ -n "$$(${DC} images -q)" ]; then docker image rm $$(${DC} images -q); fi

fclean: clean
	sudo rm -rf /home/$$USER/data

re:
	fclean all


# global docker-compose commands
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

downv:
	${DC} down -v


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

mariadb.rmv:
	${DC} rm -f -v mariadb
	docker volume rm ${NAME}_mariadb-data || true

mariadb.run: mariadb.upd mariadb.logsf

mariadb.down: mariadb.stop mariadb.rm

mariadb.downv: mariadb.stop mariadb.rmv

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

nginx.rmv:
	${DC} rm -f -v nginx

nginx.run: nginx.upd nginx.logsf

nginx.down: nginx.stop nginx.rm

nginx.downv: nginx.stop nginx.rmv

nginx.shell:
	${DC} exec nginx sh


# wordpress
wordpress.build:
	${DC} build wordpress

wordpress.logs:
	${DC} logs wordpress

wordpress.logsf:
	${DC} logs -f wordpress

wordpress.up:
	${DC} up wordpress

wordpress.upd:
	${DC} up -d wordpress

wordpress.start:
	${DC} start wordpress

wordpress.stop:
	${DC} stop wordpress

wordpress.kill:
	${DC} kill wordpress

wordpress.rm:
	${DC} rm -f wordpress

wordpress.rmv:
	${DC} rm -f -v wordpress
	docker volume rm ${NAME}_wordpress-data

wordpress.run: wordpress.upd wordpress.logsf

wordpress.down: wordpress.stop wordpress.rm

wordpress.downv: wordpress.stop wordpress.rmv

wordpress.shell:
	${DC} exec wordpress sh

wordpress.client:
	@${DC} exec wordpress sh -c "echo 'wp-cli cli info' && wp-cli cli info && echo '=> Use \`wp-cli\` to control this WordPress installation' && exec sh"


.PHONY: all run clean fclean re build up upd ps logs logsf start stop down downv mariadb.build mariadb.logs mariadb.logsf mariadb.up mariadb.upd mariadb.start mariadb.stop mariadb.kill mariadb.rm mariadb.rmv mariadb.run mariadb.down mariadb.downv mariadb.shell mariadb.client nginx.build nginx.logs nginx.logsf nginx.up nginx.upd nginx.start nginx.stop nginx.kill nginx.rm nginx.rmv nginx.run nginx.down nginx.downv nginx.shell wordpress.build wordpress.logs wordpress.logsf wordpress.up wordpress.upd wordpress.start wordpress.stop wordpress.kill wordpress.rm wordpress.rmv wordpress.run wordpress.down wordpress.downv wordpress.shell wordpress.client
