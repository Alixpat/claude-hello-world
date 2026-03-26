ARG REGISTRY=docker.io
ARG VERSION=3.22

FROM ${REGISTRY}/alpine:${VERSION}

RUN apk add --no-cache bash curl

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
