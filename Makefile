# Export environment variables from .env file
include srcs/.env
export

# Variables
NAME=inception
DC=docker-compose -f srcs/docker-compose.yaml -p ${NAME}


# General rules
all: data build run

run: ssl upd logsf

data:
	mkdir -p "/home/$$USER/data/"

ssl: data
	if [ ! -f "/home/$$USER/data/ssl/certificate.crt" ] || [ ! -f "/home/$$USER/data/ssl/private.key" ]; then \
		rm -f "/home/$$USER/data/ssl/cert.crt" "/home/$$USER/data/ssl/private.key"; \
		mkdir -p "/home/$$USER/data/ssl/"; \
		openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout "/home/$$USER/data/ssl/private.key" -out "/home/$$USER/data/ssl/certificate.crt" -subj "/CN=$$DOMAIN_NAME" -addext "subjectAltName=DNS:$$DOMAIN_NAME,DNS:$$DOMAIN_NAME"; \
	fi

clean:
	${DC} down -v
	if [ -n "$$(${DC} images -q)" ]; then \
		docker image rm $$(${DC} images -q); \
	fi

fclean: clean
	sudo rm -rf /home/$$USER/data/mariadb-data /home/$$USER/data/wordpress-data /home/$$USER/data/ssl

re: fclean all


# Global docker-compose rules
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
	docker volume rm ${NAME}_mariadb-data || true
	docker volume rm ${NAME}_wordpress-data || true


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

mariadb.shell.root:
	${DC} exec --user 0 mariadb sh

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

nginx.shell.root:
	${DC} exec --user 0 nginx sh


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
	docker volume rm ${NAME}_wordpress-data || true

wordpress.run: wordpress.upd wordpress.logsf

wordpress.down: wordpress.stop wordpress.rm

wordpress.downv: wordpress.stop wordpress.rmv

wordpress.shell:
	${DC} exec wordpress sh

wordpress.shell.root:
	${DC} exec --user 0 wordpress sh

wordpress.client:
	@${DC} exec wordpress sh -c "echo 'wp-cli cli info' && wp-cli cli info && echo '=> Use \`wp-cli\` to control this WordPress installation' && exec sh"


# adminer
adminer.build:
	${DC} build adminer

adminer.logs:
	${DC} logs adminer

adminer.logsf:
	${DC} logs -f adminer

adminer.up:
	${DC} up adminer

adminer.upd:
	${DC} up -d adminer

adminer.start:
	${DC} start adminer

adminer.stop:
	${DC} stop adminer

adminer.kill:
	${DC} kill adminer

adminer.rm:
	${DC} rm -f adminer

adminer.rmv:
	${DC} rm -f -v adminer

adminer.run: adminer.upd adminer.logsf

adminer.down: adminer.stop adminer.rm

adminer.downv: adminer.stop adminer.rmv

adminer.shell:
	${DC} exec adminer sh

adminer.shell.root:
	${DC} exec --user 0 adminer sh


# redis
redis.build:
	${DC} build redis

redis.logs:
	${DC} logs redis

redis.logsf:
	${DC} logs -f redis

redis.up:
	${DC} up redis

redis.upd:
	${DC} up -d redis

redis.start:
	${DC} start redis

redis.stop:
	${DC} stop redis

redis.kill:
	${DC} kill redis

redis.rm:
	${DC} rm -f redis

redis.rmv:
	${DC} rm -f -v redis

redis.run: redis.upd redis.logsf

redis.down: redis.stop redis.rm

redis.downv: redis.stop redis.rmv

redis.shell:
	${DC} exec redis sh

redis.shell.root:
	${DC} exec --user 0 redis sh

redis.client:
	${DC} exec redis redis-cli -h $${WP_REDIS_HOST:-redis} -n $${WP_REDIS_DATABASE:-0}


# goaccess
goaccess.build:
	${DC} build goaccess

goaccess.logs:
	${DC} logs goaccess

goaccess.logsf:
	${DC} logs -f goaccess

goaccess.up:
	${DC} up goaccess

goaccess.upd:
	${DC} up -d goaccess

goaccess.start:
	${DC} start goaccess

goaccess.stop:
	${DC} stop goaccess

goaccess.kill:
	${DC} kill goaccess

goaccess.rm:
	${DC} rm -f goaccess

goaccess.rmv:
	${DC} rm -f -v goaccess
	docker volume rm ${NAME}_goaccess-data

goaccess.run: goaccess.upd goaccess.logsf

goaccess.down: goaccess.stop goaccess.rm

goaccess.downv: goaccess.stop goaccess.rmv

goaccess.shell:
	${DC} exec goaccess sh

goaccess.shell.root:
	${DC} exec --user 0 goaccess sh


# vsftpd
vsftpd.build:
	${DC} build vsftpd

vsftpd.logs:
	${DC} logs vsftpd

vsftpd.logsf:
	${DC} logs -f vsftpd

vsftpd.up:
	${DC} up vsftpd

vsftpd.upd:
	${DC} up -d vsftpd

vsftpd.start:
	${DC} start vsftpd

vsftpd.stop:
	${DC} stop vsftpd

vsftpd.kill:
	${DC} kill vsftpd

vsftpd.rm:
	${DC} rm -f vsftpd

vsftpd.rmv:
	${DC} rm -f -v vsftpd

vsftpd.run: vsftpd.upd vsftpd.logsf

vsftpd.down: vsftpd.stop vsftpd.rm

vsftpd.downv: vsftpd.stop vsftpd.rmv

vsftpd.shell:
	${DC} exec vsftpd sh

vsftpd.shell.root:
	${DC} exec --user 0 vsftpd sh


# minisite
minisite.build:
	${DC} build minisite

minisite.logs:
	${DC} logs minisite

minisite.logsf:
	${DC} logs -f minisite

minisite.up:
	${DC} up minisite

minisite.upd:
	${DC} up -d minisite

minisite.start:
	${DC} start minisite

minisite.stop:
	${DC} stop minisite

minisite.kill:
	${DC} kill minisite

minisite.rm:
	${DC} rm -f minisite

minisite.rmv:
	${DC} rm -f -v minisite

minisite.run: minisite.upd minisite.logsf

minisite.down: minisite.stop minisite.rm

minisite.downv: minisite.stop minisite.rmv

minisite.shell:
	${DC} exec minisite sh

minisite.shell.root:
	${DC} exec --user 0 minisite sh


# PHONY
genphony:
	echo .PHONY: $$(grep -E '^[A-Za-z\.]+:[A-Za-z\. ]*$$' Makefile | cut -d: -f1 | grep -vi phony) >> Makefile
.PHONY: all run ssl clean fclean re build up upd ps logs logsf start stop down downv mariadb.build mariadb.logs mariadb.logsf mariadb.up mariadb.upd mariadb.start mariadb.stop mariadb.kill mariadb.rm mariadb.rmv mariadb.run mariadb.down mariadb.downv mariadb.shell mariadb.shell.root mariadb.client nginx.build nginx.logs nginx.logsf nginx.up nginx.upd nginx.start nginx.stop nginx.kill nginx.rm nginx.rmv nginx.run nginx.down nginx.downv nginx.shell nginx.shell.root wordpress.build wordpress.logs wordpress.logsf wordpress.up wordpress.upd wordpress.start wordpress.stop wordpress.kill wordpress.rm wordpress.rmv wordpress.run wordpress.down wordpress.downv wordpress.shell wordpress.shell.root wordpress.client adminer.build adminer.logs adminer.logsf adminer.up adminer.upd adminer.start adminer.stop adminer.kill adminer.rm adminer.rmv adminer.run adminer.down adminer.downv adminer.shell adminer.shell.root redis.build redis.logs redis.logsf redis.up redis.upd redis.start redis.stop redis.kill redis.rm redis.rmv redis.run redis.down redis.downv redis.shell redis.shell.root redis.client goaccess.build goaccess.logs goaccess.logsf goaccess.up goaccess.upd goaccess.start goaccess.stop goaccess.kill goaccess.rm goaccess.rmv goaccess.run goaccess.down goaccess.downv goaccess.shell goaccess.shell.root vsftpd.build vsftpd.logs vsftpd.logsf vsftpd.up vsftpd.upd vsftpd.start vsftpd.stop vsftpd.kill vsftpd.rm vsftpd.rmv vsftpd.run vsftpd.down vsftpd.downv vsftpd.shell vsftpd.shell.root minisite.build minisite.logs minisite.logsf minisite.up minisite.upd minisite.start minisite.stop minisite.kill minisite.rm minisite.rmv minisite.run minisite.down minisite.downv minisite.shell minisite.shell.root
