FROM resin/raspberry-pi-alpine:latest

RUN apk update
RUN apk add --no-cache ca-certificates openssl curl unbound
RUN rm -rf /var/cache/apk/*

COPY config/unbound.conf /etc/unbound/unbound.conf

RUN chown -R unbound:unbound /etc/unbound

WORKDIR /etc/unbound
USER unbound
RUN unbound-anchor -a root.key ; true
RUN unbound-control-setup
RUN curl ftp://ftp.internic.net/domain/named.cache -o root.hints

USER root
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 53/udp 53
EXPOSE 8953

VOLUME ["/etc/unbound"]

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK CMD curl ifconfig.co || exit 1
