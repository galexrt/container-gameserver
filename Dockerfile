FROM debian:stretch
LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

ENV DATA_PATH="/data" TINI_VERSION="v0.18.0" TINI_KEY="595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc

# We are not gpg checking tini as of right now Docker Hub seems to "always" have
# problems reaching the public key infrastructure.
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y gpg libc6 lib32gcc1 lib32stdc++6 libstdc++6:i386 libcurl4-gnutls-dev:i386 \
        lib32z1 lib32ncurses5 libtcmalloc-minimal4:i386 acl && \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$TINI_KEY" || \
    gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$TINI_KEY" || \
    gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$TINI_KEY" && \
    gpg --batch --verify /tini.asc /tini && \
    chmod +x /tini && \
    rm -rf /var/lib/apt/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/*

VOLUME ["$DATA_PATH"]
WORKDIR "$DATA_PATH"

ENTRYPOINT ["/tini", "--"]
