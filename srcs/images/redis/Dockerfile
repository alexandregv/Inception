FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

# dockerize setup
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# redis setup
RUN apk add redis=5.0.11-r0
RUN mkdir -p /var/log/redis && \
    chown -R redis:redis /var/log/redis

# redis conf
COPY redis.conf /etc/redis.conf

USER redis

# Create initial log file
RUN touch /var/log/redis/redis.log

EXPOSE 6379/tcp

ENTRYPOINT ["dockerize", "-stdout", "/var/log/redis/redis.log", "redis-server", "/etc/redis.conf"]
