FROM fedora:29
LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

ENV DATA_PATH="/data" TINI_VERSION="v0.18.0"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc

RUN dnf -q upgrade -y && \
    dnf install -y gpg glibc.i686 libstdc++.i686 \
        zlib.i686 libcurl.i686 ncurses-libs.i686 && \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --batch --verify /tini.asc /tini && \
    chmod +x /tini && \
    dnf clean all && \
    rm -rf /var/lib/dnf/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/*

VOLUME ["$DATA_PATH"]
WORKDIR "$DATA_PATH"

ENTRYPOINT ["/tini", "--"]
