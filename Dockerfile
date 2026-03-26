ARG REGISTRY=docker.io
ARG VERSION=3.22

FROM ${REGISTRY}/alpine:${VERSION}

ARG URL_NEXUS

RUN VERSION=$(cat /etc/alpine-release) && \
    URL="https://${URL_NEXUS##https://}/repository/alpine/v${VERSION%.*}" && \
    echo -e "${URL}/community\n${URL}/main" > /etc/apk/repositories

RUN apk add --no-cache bash curl

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN echo "" > /etc/apk/repositories

ENTRYPOINT ["entrypoint.sh"]
