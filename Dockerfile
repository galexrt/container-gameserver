FROM fedora:23
MAINTAINER Alexander Trost <galexrt@googlemail.com>

ENV DATA_PATH="/data"

ADD entrypoint.sh /entrypoint.sh

RUN dnf -q upgrade -y && \
    dnf install -y tar curl ca-certificates python glibc.i686 libstdc++.i686 zlib.i686 \
        libcurl.i686 ncurses-libs.i686 && \
    dnf clean all && \
    rm -rf /var/lib/dnf/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/*

VOLUME ["$DATA_PATH"]
WORKDIR "$DATA_PATH"

ENTRYPOINT ["/entrypoint.sh"]
