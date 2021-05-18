FROM alpine:3.12.7 as builder

# install build dependencies
RUN apk add --no-cache \
    build-base \
    gettext-dev \
    gettext-static \
    libmaxminddb-dev \
    ncurses-dev \
    ncurses-static \
    autoconf \
    automake \
    build-base \
    clang \
    clang-static \
    gettext-dev \
    gettext-static \
    git \
    libmaxminddb-dev \
    libressl-dev \
    linux-headers \
    ncurses-dev \
    ncurses-static \
    tzdata

# download and compile goaccess
ENV GOACCESS_VERSION 1.4.6
WORKDIR /
RUN wget https://tar.goaccess.io/goaccess-$GOACCESS_VERSION.tar.gz && \
    tar -xzvf goaccess-$GOACCESS_VERSION.tar.gz && \
    mv goaccess-$GOACCESS_VERSION goaccess
WORKDIR /goaccess
RUN autoreconf -fiv
RUN CC="clang" CFLAGS="-O3 -static" LIBS="$(pkg-config --libs openssl)" ./configure --prefix="" --enable-utf8 --with-openssl --enable-geoip=mmdb
RUN make && make DESTDIR=/dist install


FROM alpine:3.12.7

LABEL maintainer="aguiot--@student.42.fr"

COPY --from=builder /dist /
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

WORKDIR /goaccess

COPY goaccess.conf /goaccess/goaccess.conf

# user setup
RUN adduser -D -g 'goaccess' goaccess && \
	mkdir -p /goaccess/data /goaccess/html && \
	chown -R goaccess:goaccess /goaccess
USER goaccess

EXPOSE 7890

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
