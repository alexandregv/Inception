FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

RUN apk add redis=5.0.11-r0

COPY redis.conf /etc/redis.conf

USER redis

EXPOSE 6379/tcp

ENTRYPOINT ["redis-server", "/etc/redis.conf"]
