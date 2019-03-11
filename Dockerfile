FROM debian:jessie
LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

ENV DATA_PATH="/data" TINI_VERSION="v0.18.0"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

# We are not gpg checking tini as of right now Docker Hub seems to "always" have
# problems reaching the public key infrastructure.
RUN dpkg --add-architecture i386 && \
    apt update -y && \
    apt install -y libc6 lib32gcc1 lib32stdc++6 libstdc++6:i386 libcurl4-gnutls-dev:i386 \
        lib32z1 lib32ncurses5 libtcmalloc-minimal4:i386 && \
    chmod +x /tini && \
    rm -rf /var/lib/apt/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/*

VOLUME ["$DATA_PATH"]
WORKDIR "$DATA_PATH"

ENTRYPOINT ["/tini", "--"]
