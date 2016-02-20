FROM gliderlabs/alpine:3.3
MAINTAINER Alexander Trost <galexrt@googlemail.com>

ADD entrypoint.sh /entrypoint.sh

RUN apk --no-cache add --update bash
        curl \
        python \
        python-dev \
        glib \
        libstdc++ && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
