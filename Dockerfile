FROM debian:buster

ARG BUILD_DATE="N/A"
ARG REVISION="N/A"

ARG TINI_ARCH="amd64"

LABEL org.opencontainers.image.authors="Alexander Trost <galexrt@googlemail.com>" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.title="galexrt/container-gameserver" \
    org.opencontainers.image.description="Container Image for running (some) Gameservers easily in Containers." \
    org.opencontainers.image.documentation="https://github.com/galexrt/container-gameserver/blob/main/README.md" \
    org.opencontainers.image.url="https://github.com/galexrt/container-gameserver" \
    org.opencontainers.image.source="https://github.com/galexrt/container-gameserver" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.vendor="galexrt" \
    org.opencontainers.image.version="N/A"

ENV DATA_DIR="/data" \
    TINI_VERSION="v0.19.0" \
    TINI_ARCH="${TINI_ARCH}"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TINI_ARCH} /tini-${TINI_ARCH}
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TINI_ARCH}.sha256sum /tini-${TINI_ARCH}.sha256sum

# We are not gpg checking tini as of right now Docker Hub seems to "always" have
# problems reaching the public key infrastructure.
RUN dpkg --add-architecture i386 && \
    apt update && \
    DEBIAN_FRONTEND="noninteractive" apt install -y libc6 lib32gcc1 lib32stdc++6 \
        libstdc++6:i386 libcurl4-gnutls-dev:i386 lib32z1 lib32ncurses5-dev lib32ncurses6 \
        libtcmalloc-minimal4:i386 acl tzdata gdb libncurses5:i386 libstdc++5:i386 libtinfo5:i386 && \
    cd / && \
    echo "$(cat /tini-${TINI_ARCH}.sha256sum)" | sha256sum -c && \
    mv "/tini-${TINI_ARCH}" /tini && \
    chmod 755 /tini && \
    rm -rf /var/lib/apt/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/*

VOLUME ["${DATA_DIR}"]

WORKDIR "${DATA_DIR}"

ENTRYPOINT ["/tini", "--"]
