FROM alpine:edge

RUN addgroup -g 2000 rspamd && adduser -u 2000 -G rspamd -h /var/lib/rspamd -D -s /sbin/nologin rspamd

# We have to upgrade musl, or rspamd will not work.
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
 && apk add --no-cache rspamd rspamd-controller rsyslog ca-certificates

RUN mkdir /run/rspamd

COPY conf/ /etc/rspamd
COPY start.sh /start.sh

CMD ["/start.sh"]
