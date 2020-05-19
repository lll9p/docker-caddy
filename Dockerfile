#https://hub.docker.com/_/caddy
FROM caddy:2.0.0-builder AS builder

RUN caddy-builder \
    github.com/mholt/caddy-webdav

FROM caddy:2.0.0

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add --no-cache libcap \
    && setcap 'cap_net_bind_service=+ep' /usr/bin/caddy
