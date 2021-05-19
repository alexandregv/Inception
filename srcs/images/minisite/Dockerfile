FROM alpine:3.12.7 as go-builder

LABEL maintainer="aguiot--@student.42.fr"

# go setup
RUN apk add go=1.13.15-r0

WORKDIR /app

# copy source code and compile
COPY . .
RUN go build -ldflags "-w -s" .


FROM alpine:3.12.7 as final

WORKDIR /app

# copy compiled binary file from go-builder
COPY --from=go-builder /app/minisite ./minisite

# copy config and resources (assets)
COPY config.production.json ./config.production.json
COPY resources ./resources

# user setup
RUN adduser -S -H go-exec -s /bin/false
RUN chown -R go-exec /app
USER go-exec

EXPOSE 80/tcp

ENV GOYAVE_ENV=production

ENTRYPOINT ["./minisite"]
