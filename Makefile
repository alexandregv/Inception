NAME=inception
DC=docker-compose -f srcs/docker-compose.yaml -p ${NAME}

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
