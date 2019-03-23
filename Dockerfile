FROM alpine:edge

# We have to upgrade musl, or rspamd will not work.
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
 && apk add --no-cache rspamd rspamd-controller rsyslog ca-certificates

RUN groupadd -g 2000 rspamd && useradd --no-log-init -u 2000 -g rspamd rspamd

RUN mkdir /run/rspamd

COPY conf/ /etc/rspamd
COPY start.sh /start.sh

CMD ["/start.sh"]
