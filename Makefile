# Export environment variables from .env file
include srcs/.env
export

# Variables
NAME=inception
DC=docker-compose -f srcs/docker-compose.yaml -p ${NAME}


# General rules
all: data build run

# Generate help message from Makefile
# Found at https://gist.github.com/prwhite/8168133 and modified to support semicolons in target name
# See https://gist.github.com/prwhite/8168133?permalink_comment_id=4160123#gistcomment-4160123
help:                          ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@awk 'BEGIN {FS = ": .*##"} /^[$$()% 0-9a-zA-Z_-]+(\\:help+)+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

run: ssl upd logsf             ## Run the project

data:                          ## Ensure the /home/$USER/data folder exists
	mkdir -p "/home/$$USER/data/"

ssl: data                      ## Generate SSL certificate
	if [ ! -f "/home/$$USER/data/ssl/certificate.crt" ] || [ ! -f "/home/$$USER/data/ssl/private.key" ]; then \
		rm -f "/home/$$USER/data/ssl/cert.crt" "/home/$$USER/data/ssl/private.key"; \
		mkdir -p "/home/$$USER/data/ssl/"; \
		openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout "/home/$$USER/data/ssl/private.key" -out "/home/$$USER/data/ssl/certificate.crt" -subj "/CN=$$DOMAIN_NAME" -addext "subjectAltName=DNS:$$DOMAIN_NAME,DNS:$$DOMAIN_NAME"; \
	fi

clean:                         ## Stop the containers and delete the images
	${DC} down -v
	if [ -n "$$(${DC} images -q)" ]; then \
		docker image rm $$(${DC} images -q); \
	fi

fclean: clean                  ## Delete data in /home/$USER/data
	sudo rm -rf /home/$$USER/data/mariadb-data /home/$$USER/data/wordpress-data /home/$$USER/data/ssl

re: fclean all                 ## fclean + all


# Global docker-compose rules
build:                         ## Build all images
	${DC} build

up:                            ## Up all containers (attached)
	${DC} up

upd:                           ## Up all containers (detached)
	${DC} up -d

ps:                            ## Show status
	${DC} ps

logs:                          ## Show all logs (no follow)
	${DC} logs

logsf:                         ## Show all logs (follow)
	${DC} logs -f

start:                         ## Start all containers
	${DC} start

stop:                          ## Stop all containers
	${DC} stop

down:                          ## Down (stop + rm) all containers
	${DC} down

downv:                         ## Down (stop + rm) all containers with their volumes
	${DC} down -v
	docker volume rm ${NAME}_mariadb-data || true
	docker volume rm ${NAME}_wordpress-data || true


# mariadb
mariadb\:help:                 ## Show help about mariadb commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^mariadb\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

mariadb\:build:                ## Build mariadb image
	${DC} build mariadb

mariadb\:logs:                 ## Show mariadb logs (no follow)
	${DC} logs mariadb

mariadb\:logsf:                ## Show mariadb logs (follow)
	${DC} logs -f mariadb

mariadb\:up:                   ## Up mariadb container (attached)
	${DC} up mariadb

mariadb\:upd:                  ## Up mariadb container (detached)
	${DC} up -d mariadb

mariadb\:start:                ## Start mariadb container
	${DC} start mariadb

mariadb\:stop:                 ## Stop mariadb container
	${DC} stop mariadb

mariadb\:kill:                 ## Stop mariadb container
	${DC} kill mariadb

mariadb\:rm:                   ## Delete mariadb container
	${DC} rm -f mariadb

mariadb\:rmv:                  ## Delete mariadb container and volume
	${DC} rm -f -v mariadb
	docker volume rm ${NAME}_mariadb-data || true

mariadb\:run: mariadb.upd mariadb.logsf   ## Up mariadb and follow logs

mariadb\:down: mariadb.stop mariadb.rm    ## Stop mariadb and delete container

mariadb\:downv: mariadb.stop mariadb.rmv  ## Stop mariadb and delete container and volume

mariadb\:shell:                ## Open a shell inside mariadb container 
	${DC} exec mariadb sh

mariadb\:rootshell:           ## Open a root shell inside mariadb container
	${DC} exec --user 0 mariadb sh

mariadb\:client:
	${DC} exec mariadb mariadb --socket=/var/lib/mysql/mysql.sock


# nginx
nginx\:help:                        ## Show help about nginx commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^nginx\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

nginx\:build:                       ## Build mariadb image
	${DC} build nginx

nginx\:logs:                        ## Show nginx logs (no follow)
	${DC} logs nginx

nginx\:logsf:                       ## Show nginx logs (follow)
	${DC} logs -f nginx

nginx\:up:                          ## Up nginx container (attached)
	${DC} up nginx

nginx\:upd:                         ## Up nginx container (detached)
	${DC} up -d nginx

nginx\:start:                       ## Start nginx container
	${DC} start nginx

nginx\:stop:                        ## Stop nginx container
	${DC} stop nginx

nginx\:kill:                        ## Kill nginx container
	${DC} kill nginx

nginx\:rm:                          ## Delete nginx container
	${DC} rm -f nginx

nginx\:rmv:                         ## Delete nginx container and volume
	${DC} rm -f -v nginx

nginx\:run: nginx.upd nginx.logsf   ## Up nginx and follow logs

nginx\:down: nginx.stop nginx.rm    ## Stop and delete nginx container

nginx\:downv: nginx.stop nginx.rmv  ## Stop and delete nginx container and volume

nginx\:shell:                       ## Open a shell inside nginx container
	${DC} exec nginx sh

nginx\:rootshell:                   ## Open a root shell inside nginx container
	${DC} exec --user 0 nginx sh


# wordpress
wordpress\:help:                    ## Show help about wordpress commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^wordpress\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

wordpress\:build:                   ## Build wordpress image
	${DC} build wordpress

wordpress\:logs:                    ## Show wordpress logs (no follow)
	${DC} logs wordpress

wordpress\:logsf:                   ## Show wordpress logs (follow)
	${DC} logs -f wordpress

wordpress\:up:                      ## Up wordpress container (attached)
	${DC} up wordpress

wordpress\:upd:                     ## Up wordpress container (detached)
	${DC} up -d wordpress

wordpress\:start:                   ## Start wordpress container
	${DC} start wordpress

wordpress\:stop:                    ## Stop wordpress container
	${DC} stop wordpress

wordpress\:kill:                    ## Kill wordpress container
	${DC} kill wordpress

wordpress\:rm:                      ## Delete wordpress container
	${DC} rm -f wordpress

wordpress\:rmv:                     ## Delete wordpress container and volume
	${DC} rm -f -v wordpress
	docker volume rm ${NAME}_wordpress-data || true

wordpress\:run: wordpress.upd wordpress.logsf   ## Up wordpress and follow logs

wordpress\:down: wordpress.stop wordpress.rm    ## Stop mariadb and delete container

wordpress\:downv: wordpress.stop wordpress.rmv  ## Stop mariadb and delete container and volume

wordpress\:shell:                   ## Open a shell inside wordpress container
	${DC} exec wordpress sh

wordpress\:rootshell:               ## Open a root shell inside wordpress container
	${DC} exec --user 0 wordpress sh

wordpress\:client:                  ## Open wp-cli inside wordpress container
	@${DC} exec wordpress sh -c "echo 'wp-cli cli info' && wp-cli cli info && echo '=> Use \`wp-cli\` to control this WordPress installation' && exec sh"


# adminer
adminer\:help:                      ## Show help about adminer commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^adminer\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

adminer\:build:                     ## Build adminer image
	${DC} build adminer

adminer\:logs:                      ## Show adminer logs (no follow)
	${DC} logs adminer

adminer\:logsf:                     ## Show adminer logs (follow)
	${DC} logs -f adminer

adminer\:up:                        ## Up adminer container (attached)
	${DC} up adminer

adminer\:upd:                       ## Up adminer container (detached)
	${DC} up -d adminer

adminer\:start:                     ## Start adminer container
	${DC} start adminer

adminer\:stop:                      ## Stop adminer container
	${DC} stop adminer

adminer\:kill:                      ## Kill adminer container
	${DC} kill adminer

adminer\:rm:                        ## Delete adminer container
	${DC} rm -f adminer

adminer\:rmv:                       ## Delete adminer container and volume
	${DC} rm -f -v adminer

adminer\:run: adminer.upd adminer.logsf   ## Up adminer and follow logs

adminer\:down: adminer.stop adminer.rm    ## Stop adminer and delete container

adminer\:downv: adminer.stop adminer.rmv  ## Stop adminer and delete container and volume

adminer\:shell:                     ## Open a shell inside adminer container
	${DC} exec adminer sh

adminer\:rootshell:                 ## Open a root shell inside adminer container
	${DC} exec --user 0 adminer sh


# redis
redis\:help:                        ## Show help about redis commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^redis\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

redis\:build:                       ## Build redis image
	${DC} build redis

redis\:logs:                        ## Show redis logs (no follow)
	${DC} logs redis

redis\:logsf:                       ## Show redis logs (follow)
	${DC} logs -f redis

redis\:up:                          ## Up redis container (attached)
	${DC} up redis

redis\:upd:                         ## Up redis container (detached)
	${DC} up -d redis

redis\:start:                       ## Start redis container
	${DC} start redis

redis\:stop:                        ## Stop redis container
	${DC} stop redis

redis\:kill:                        ## Kill redis container
	${DC} kill redis

redis\:rm:                          ## Delete redis container
	${DC} rm -f redis

redis\:rmv:                         ## Delete redis container and volume
	${DC} rm -f -v redis

redis\:run: redis.upd redis.logsf   ## Up redis and follow logs

redis\:down: redis.stop redis.rm    ## Down redis and delete container

redis\:downv: redis.stop redis.rmv  ## Down redis and delete container and volume

redis\:shell:                       ## Open a shell inside redis container
	${DC} exec redis sh

redis\:shell.root:                  ## Open a root shell inside redis container
	${DC} exec --user 0 redis sh

redis\:client:                      ## Open redis-cli client inside redis container
	${DC} exec redis redis-cli -h $${WP_REDIS_HOST:-redis} -n $${WP_REDIS_DATABASE:-0}


# goaccess
goaccess\:help:                     ## Show help about goaccess commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^goaccess\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

goaccess\:build:                    ## Build goaccess image
	${DC} build goaccess

goaccess\:logs:                     ## Show goaccess logs (no follow)
	${DC} logs goaccess

goaccess\:logsf:                    ## Show goaccess logs (follow)
	${DC} logs -f goaccess

goaccess\:up:                       ## Up goaccess container (attached)
	${DC} up goaccess

goaccess\:upd:                      ## Up goaccess container (detached)
	${DC} up -d goaccess

goaccess\:start:                    ## Start goaccess container
	${DC} start goaccess

goaccess\:stop:                     ## Stop goaccess container
	${DC} stop goaccess

goaccess\:kill:                     ## Kill goaccess container
	${DC} kill goaccess

goaccess\:rm:                       ## Delete goaccess container
	${DC} rm -f goaccess

goaccess\:rmv:                      ## Delete goaccess container and volume
	${DC} rm -f -v goaccess
	docker volume rm ${NAME}_goaccess-data

goaccess\:run: goaccess.upd goaccess.logsf   ## Up goaccess and follow logs

goaccess\:down: goaccess.stop goaccess.rm    ## Down goaccess and delete container

goaccess\:downv: goaccess.stop goaccess.rmv  ## Down goaccess and delete container and volume

goaccess\:shell:                    ## Open a shell inside goaccess container
	${DC} exec goaccess sh

goaccess\:shell.root:               ## Open a root shell inside goaccess container
	${DC} exec --user 0 goaccess sh


# vsftpd
vsftpd\:help:                       ## Show help about vsftpd commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^vsftpd\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

vsftpd\:build:                      ## Build vsftpd image
	${DC} build vsftpd

vsftpd\:logs:                       ## Show vsftpd logs (no follow)
	${DC} logs vsftpd

vsftpd\:logsf:                      ## Show vsftpd logs (follow)
	${DC} logs -f vsftpd

vsftpd\:up:                         ## Up vsftpd container (attached)
	${DC} up vsftpd

vsftpd\:upd:                        ## Up vsftpd container (detached)
	${DC} up -d vsftpd

vsftpd\:start:                      ## Start vsftpd container
	${DC} start vsftpd

vsftpd\:stop:                       ## Stop vsftpd container
	${DC} stop vsftpd

vsftpd\:kill:                       ## Kill vsftpd container
	${DC} kill vsftpd

vsftpd\:rm:                         ## Delete vsftpd container
	${DC} rm -f vsftpd

vsftpd\:rmv:                        ## Delete vsftpd container and volume
	${DC} rm -f -v vsftpd

vsftpd\:run: vsftpd.upd vsftpd.logsf   ## Up vsftpd and follow logs

vsftpd\:down: vsftpd.stop vsftpd.rm    ## Down vsftpd and delete container

vsftpd\:downv: vsftpd.stop vsftpd.rmv  ## Down vsftpd and delete container and volume

vsftpd\:shell:                         ## Open a shell inside vsftpd container
	${DC} exec vsftpd sh

vsftpd\:shell.root:                    ## Open a root shell inside vsftpd container
	${DC} exec --user 0 vsftpd sh


# minisite
minisite\:help:                     ## Show help about minisite commands
	@awk 'BEGIN {FS = ": .*##"; printf "Usage:\n  make \033[36m\033[0m\n"} /^minisite\\:[$$()% 0-9a-zA-Z_-]+:.*?##/ { gsub(/\\:/,":", $$1); printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

minisite\:build:                    ## Build minisite image
	${DC} build minisite

minisite\:logs:                     ## Show minisite logs (no follow)
	${DC} logs minisite

minisite\:logsf:                    ## Show minisite logs (follow)
	${DC} logs -f minisite

minisite\:up:                       ## Up minisite container (attached)
	${DC} up minisite

minisite\:upd:                      ## Up minisite container (detached)
	${DC} up -d minisite

minisite\:start:                    ## Start minisite container
	${DC} start minisite

minisite\:stop:                     ## Stop minisite container
	${DC} stop minisite

minisite\:kill:                     ## Kill minisite container
	${DC} kill minisite

minisite\:rm:                       ## Delete minisite container
	${DC} rm -f minisite

minisite\:rmv:                      ## Delete minisite container and volume
	${DC} rm -f -v minisite

minisite\:run: minisite.upd minisite.logsf   ## Up minisite and follow logs

minisite\:down: minisite.stop minisite.rm    ## Down minisite and delete container

minisite\:downv: minisite.stop minisite.rmv  ## Down minisite and delete container and volume

minisite\:shell:                    ## Open a shell inside minisite container
	${DC} exec minisite sh

minisite\:shell.root:               ## Open a root shell inside minisite container
	${DC} exec --user 0 minisite sh


# PHONY
genphony:
	echo .PHONY: $$(grep -E '^([A-Za-z]+:[A-Za-z ]*)|(^[A-Za-z\\:]+:[A-Za-z\\: ]*)$$' Makefile | rev | cut -d: -f2- | rev | grep -v phony) >> Makefile
.PHONY: all run ssl clean fclean re build up upd ps logs logsf start stop down downv mariadb\:build mariadb\:logs mariadb\:logsf mariadb\:up mariadb\:upd mariadb\:start mariadb\:stop mariadb\:kill mariadb\:rm mariadb\:rmv mariadb\:run mariadb\:down mariadb\:downv mariadb\:shell mariadb\:rootshell mariadb\:client nginx\:build nginx\:logs nginx\:logsf nginx\:up nginx\:upd nginx\:start nginx\:stop nginx\:kill nginx\:rm nginx\:rmv nginx\:run nginx\:down nginx\:downv nginx\:shell nginx\:rootshell wordpress\:build wordpress\:logs wordpress\:logsf wordpress\:up wordpress\:upd wordpress\:start wordpress\:stop wordpress\:kill wordpress\:rm wordpress\:rmv wordpress\:run wordpress\:down wordpress\:downv wordpress\:shell wordpress\:rootshell wordpress\:client adminer\:build adminer\:logs adminer\:logsf adminer\:up adminer\:upd adminer\:start adminer\:stop adminer\:kill adminer\:rm adminer\:rmv adminer\:run adminer\:down adminer\:downv adminer\:shell adminer\:rootshell redis\:build redis\:logs redis\:logsf redis\:up redis\:upd redis\:start redis\:stop redis\:kill redis\:rm redis\:rmv redis\:run redis\:down redis\:downv redis\:shell redis\:rootshell redis\:client goaccess\:build goaccess\:logs goaccess\:logsf goaccess\:up goaccess\:upd goaccess\:start goaccess\:stop goaccess\:kill goaccess\:rm goaccess\:rmv goaccess\:run goaccess\:down goaccess\:downv goaccess\:shell goaccess\:rootshell vsftpd\:build vsftpd\:logs vsftpd\:logsf vsftpd\:up vsftpd\:upd vsftpd\:start vsftpd\:stop vsftpd\:kill vsftpd\:rm vsftpd\:rmv vsftpd\:run vsftpd\:down vsftpd\:downv vsftpd\:shell vsftpd\:rootshell minisite\:build minisite\:logs minisite\:logsf minisite\:up minisite\:upd minisite\:start minisite\:stop minisite\:kill minisite\:rm minisite\:rmv minisite\:run minisite\:down minisite\:downv minisite\:shell minisite\:rootshell
