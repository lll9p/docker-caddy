#https://hub.docker.com/_/caddy
FROM caddy:2.0.0-builder AS builder

RUN caddy-builder \
    github.com/mholt/caddy-webdav

FROM caddy:2.0.0

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add --no-cache libcap tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata \
    && mkdir -p /usr/share/zoneinfo/Asia/ \
    && ln -s /etc/localtime /usr/share/zoneinfo/Asia/Shanghai \
    && setcap 'cap_net_bind_service=+ep' /usr/bin/caddy
