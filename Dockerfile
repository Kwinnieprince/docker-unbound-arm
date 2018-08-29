FROM easypi/alpine-arm:3.8 as alpine

RUN apk --update add --no-cache ca-certificates curl
RUN curl ftp://ftp.internic.net/domain/named.cache -o /root/root.hints

FROM easypi/alpine-arm:3.8

RUN apk --update add --no-cache bash openssl unbound bind-tools

COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=alpine /root/root.hints /etc/unbound/root.hints
COPY config/unbound.conf /etc/unbound/unbound.conf

RUN chown -R unbound:unbound /etc/unbound

WORKDIR /etc/unbound
USER unbound
RUN unbound-anchor -a root.key ; true
RUN unbound-control-setup

USER root
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 53/udp 53
EXPOSE 8953

VOLUME ["/etc/unbound"]

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK CMD dig google.com || exit 1
